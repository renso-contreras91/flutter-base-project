import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Paleta base
// ─────────────────────────────────────────────────────────────────────────────
abstract final class AppColors {
  static const primary = Color(0xFF3A7BD5);
  static const primaryLight = Color(0xFF68A7FF);
  static const primaryDark = Color(0xFF1A4E99);
  static const accent = Color(0xFF26C6DA);

  // — Semánticos ──────────────────────────────────────────────────────────────
  static const success = Color(0xFFCDEEDC); // Verde pastel — fondos/contenedores de éxito
  static const error = Color(0xFFFACDCF); // Rojo pastel — fondos/contenedores de error
  static const informative = Color(0xFFD3DEFF); // Azul pastel — fondos/contenedores informativos
  static const action = Color(0xFFFF9F43); // Naranja — acciones secundarias, advertencias
  static const notice = Color(0xFFFFF9C4); // Amarillo pastel — destacar sin alarmar
  static const noticeStrong = Color(0xFFF9E44A); // Amarillo medio — destacar con contraste moderado
  static const danger = Color(0xFFB71C1C); // Rojo sólido — texto/iconos de error sobre fondo claro
  static const successSolid = Color(0xFF43A047); // Verde sólido — texto/iconos de éxito sobre fondo claro
  static const noticeSolid = Color(0xFF3D3600);

  // — Sticker types ───────────────────────────────────────────────────────────
  static const stickerBronze = Color(0xFF9C6B3C); // bronce real: marrón-dorado cálido
  static const stickerSilver = Color(0xFFA8B8C8); // plata clara — azul frío, luminoso
  static const stickerGolden = Color(0xFFF0B429); // oro luminoso, cálido
  static const stickerChrome = Color(0xFF546E7A); // acero oscuro — industrial, Blue Grey 700
  static const stickerHolo = Color(0xFFE040FB); // Magenta vibrante — efecto prisma/arcoíris
  static const stickerFoil = Color(0xFFB8A99A); // plata cálida — arena
  static const stickerSpecial = Color(0xFFD81B60); // rosa-fucsia intenso, categoría propia
  static const stickerBuildable = Color(0xFF00897B); // armable: teal medio (Teal 600)
  static const stickerDieCut = Color(0xFF43A047); // troquelado: verde puro (Green 600)
  static const stickerScratch = Color(0xFFE65100); // naranja intenso — revelación/sorpresa
  static const stickerFabric = Color(0xFF8D6E63); // marrón rosado cálido — material orgánico

  // — Collection type accents ─────────────────────────────────────────────────
  static const collectionTypeSticker = Color(0xFF7F77DD); // purple mid
  static const collectionTypeTap = Color(0xFF1D9E75); // teal mid
  static const collectionTypeCard = Color(0xFFBA7517); // amber mid
}

// ─────────────────────────────────────────────────────────────────────────────
// 🌞 Light ColorScheme
//
// Migraciones desde Compose M3 → Flutter M3:
//   background    → surface          (fondo principal de la app)
//   onBackground  → onSurface        (texto/iconos sobre ese fondo)
//   surfaceVariant  → surfaceContainerHighest  (contenedor elevado)
//   onSurfaceVariant → onSurfaceVariant  (sin cambio de nombre, sí de semántica)
// ─────────────────────────────────────────────────────────────────────────────
const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: AppColors.primary,
  onPrimary: Colors.white,
  secondary: AppColors.accent,
  onSecondary: Colors.white,
  tertiary: AppColors.primaryDark,
  onTertiary: Colors.white,
  surface: Color(0xFFFDFDFD), // ex-background + ex-surface unificados
  onSurface: Color(0xFF1C1B1F), // ex-onBackground
  surfaceContainerHighest: Color(0xFFE7E0EC), // ex-surfaceVariant
  onSurfaceVariant: Color(0xFF49454F), // ex-onSurfaceVariant
  error: Color(0xFFBA1A1A),
  onError: Colors.white,
  errorContainer: AppColors.error,
  onErrorContainer: Color(0xFF410002),
  outline: Color(0xFF79747E),
);

// ─────────────────────────────────────────────────────────────────────────────
// 🌙 Dark ColorScheme
// ─────────────────────────────────────────────────────────────────────────────
const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFF8EC5FF), // versión clara del azul — consistente con identidad
  onPrimary: Color(0xFF003063),
  secondary: AppColors.accent,
  onSecondary: Color(0xFF003640),
  tertiary: AppColors.primaryLight,
  onTertiary: Color(0xFF003063),
  surface: Color(0xFF1E1E1E), // ex-background + ex-surface unificados
  onSurface: Color(0xFFE6E1E5), // ex-onBackground
  surfaceContainerHighest: Color(0xFF49454F), // ex-surfaceVariant
  onSurfaceVariant: Color(0xFFCAC4D0), // ex-onSurfaceVariant
  error: Color(0xFFCF6679),
  onError: Colors.black,
  errorContainer: Color(0xFF8C1D18),
  onErrorContainer: Color(0xFFF9DEDC),
  outline: Color(0xFF938F99),
);
