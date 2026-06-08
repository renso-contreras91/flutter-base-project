// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get errorNetwork =>
      'No se puede acceder al servidor. Verifique su conexión e inténtelo nuevamente.';

  @override
  String get errorTimeout =>
      'No se pudo comunicar con el servidor, vuelva a intentarlo.';

  @override
  String get errorSecureConnection =>
      'No se ha podido establecer una conexión segura con el servidor.';

  @override
  String get errorJobCancellation => 'Tarea cancelada.';

  @override
  String get errorUnknown => 'Ha ocurrido un error.';

  @override
  String get errorEmptyResponse => 'Ocurrió un error.';

  @override
  String errorUnauthorized(String message) {
    return 'Su sesión ha expirado. Por favor vuelva a iniciar sesión. $message';
  }

  @override
  String errorForbidden(String message) {
    return '¡Acceso denegado! $message';
  }

  @override
  String errorBadRequest(String message) {
    return 'El servidor no puede procesar la petición. $message';
  }

  @override
  String errorNotFound(String message) {
    return 'Página no disponible. $message';
  }

  @override
  String errorConflict(String message) {
    return 'La solicitud no pudo completarse debido a un conflicto. $message';
  }

  @override
  String errorPayloadTooLarge(String message) {
    return 'La solicitud es mayor que los límites del servidor. $message';
  }

  @override
  String errorMakePayment(String message) {
    return 'El contenido no está disponible hasta realizar un pago. $message';
  }

  @override
  String errorServer(String message) {
    return 'El servidor no está disponible, vuelva a intentarlo. $message';
  }

  @override
  String get email => 'Correo';

  @override
  String get password => 'Contraseña';

  @override
  String get enterEmail => 'Ingrese el correo electrónico';

  @override
  String get rememberMyAccount => 'Recordar mi cuenta';

  @override
  String get enter => 'Entrar';

  @override
  String enterPasswordMinChars(int count) {
    return 'Ingresa una contraseña de al menos $count caracteres';
  }
}
