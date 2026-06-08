# Yala — Flutter

## Arquitectura

El proyecto sigue una arquitectura en capas inspirada en **Clean Architecture**, separando responsabilidades en cuatro capas principales:

```
lib/
├── config/          # Configuración global (Firebase, flavors, build constants)
├── di/              # Inyección de dependencias (GetIt)
├── common/          # Recursos compartidos (tema, rutas, constantes, extensiones, enums)
├── domain/          # Capa de dominio: modelos, repositorios (interfaces), casos de uso, Result/Failure
├── data/            # Capa de datos: datasources, implementaciones de repositorios, red, almacenamiento local
└── presentation/    # Capa de presentación: pantallas, BLoCs, widgets
```

### Capas

| Capa | Responsabilidad |
|------|----------------|
| `domain` | Contratos (interfaces de repositorios), casos de uso, modelos de negocio y tipos `Result`/`AppFailure` |
| `data` | Implementación de repositorios, datasources HTTP (Dio), almacenamiento seguro y preferencias |
| `presentation` | UI con Flutter Widgets, gestión de estado con BLoC |
| `di` | Configuración del service locator con GetIt, organizado por módulos |

---

## Gestión de estado

**flutter_bloc** — cada pantalla tiene su propio `Bloc` con eventos, estados e interacción con casos de uso.

El patrón seguido por cada BLoC:

```
Event → Bloc → UseCase → Repository → DataSource
                ↓
             State (emitido hacia la UI)
```

Los estados se modelan con `copyWith` y usan `Equatable` para comparaciones eficientes.

---

## Manejo de errores

Se usa un tipo `Result<T>` sellado (sealed class) propio, sin librerías externas:

```dart
sealed class Result<T> {}
class Success<T> extends Result<T> { final T? response; }
class Failure<T> extends Result<T> { final AppFailure appFailure; }
```

`AppFailure` es también una sealed class que mapea errores de red, HTTP y de negocio:

```
FailureNetwork, FailureUnauthorized, FailureForbidden, FailureTimeout,
FailureBadRequest, FailureNotFound, FailureConflict, FailureDetected,
FailureServer, FailureNone, FailureLocal, ...
```

El `NetworkHandler` centraliza toda la lógica de manejo de respuestas HTTP y excepciones de Dio, incluyendo mapeo automático de códigos de error a `AppFailure`.

---

## Inyección de dependencias

**GetIt** como service locator. La configuración está modularizada por tipo:

```
di/instances/
├── instance_network.dart       # Dio, NetworkHandler
├── instance_datasources.dart   # DataSources
├── instance_repositories.dart  # Repositorios
├── instance_usecases.dart      # Casos de uso
├── instance_secure_storage.dart
├── instance_connection.dart
└── instance_package_info.dart
```

---

## Navegación

**go_router** con rutas declaradas en una clase `AppRoutes` como constantes estáticas.

---

## Flavors

El proyecto soporta dos entornos mediante un `FlavorEnum`:

| Flavor | Entry point |
|--------|------------|
| `DEV`  | `lib/config/main/main_dev.dart` |
| `PROD` | `lib/config/main/main_prod.dart` |

Cada flavor tiene su propia configuración de Firebase (`firebase_options_dev` / `firebase_options_prod`) y su base URL.

---

## Librerías principales

### Estado y dominio
| Librería | Uso |
|----------|-----|
| `flutter_bloc` | Gestión de estado |
| `equatable` | Comparación de estados/eventos |

### Red
| Librería | Uso |
|----------|-----|
| `dio` | Cliente HTTP |
| `connectivity_plus` | Detección de conectividad antes de cada request |

### Almacenamiento
| Librería | Uso |
|----------|-----|
| `flutter_secure_storage` | Tokens y datos sensibles |

### Navegación
| Librería | Uso |
|----------|-----|
| `go_router` | Navegación declarativa |

### Firebase
| Librería | Uso |
|----------|-----|
| `firebase_core` | Inicialización |
| `firebase_crashlytics` | Reporte de errores en producción |
| `firebase_analytics` | Analítica |
| `firebase_remote_config` | Configuración remota |

### Configuración y utilidades
| Librería | Uso |
|----------|-----|
| `get_it` | Service locator / DI |
| `flutter_dotenv` | Variables de entorno (`.env`) |
| `flutter_native_splash` | Splash screen nativo |
| `flutter_svg` | Imágenes SVG |
| `package_info_plus` | Info de versión de la app |
| `intl` | Internacionalización |

### Internacionalización
El proyecto usa `flutter_localizations` con generación de ARB. Soporta **español** e **inglés**.

---

## Fuente

Fuente personalizada: **Nunito** (pesos 200–900, variantes regular e itálica), configurada en `pubspec.yaml` y aplicada globalmente via `AppTheme`.

---

## Tema

`AppTheme` define esquemas de color para **light** y **dark mode** usando Material 3 (`useMaterial3: true`), respetando el `ThemeMode.system` del dispositivo.
