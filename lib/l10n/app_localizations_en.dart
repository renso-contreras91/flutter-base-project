// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get errorNetwork =>
      'Unable to reach the server. Please check your connection and try again.';

  @override
  String get errorTimeout =>
      'Could not communicate with the server, please try again.';

  @override
  String get errorSecureConnection =>
      'Could not establish a secure connection with the server.';

  @override
  String get errorJobCancellation => 'Task cancelled.';

  @override
  String get errorUnknown => 'An error has occurred.';

  @override
  String get errorEmptyResponse => 'An error occurred.';

  @override
  String errorUnauthorized(String message) {
    return 'Your session has expired. Please log in again. $message';
  }

  @override
  String errorForbidden(String message) {
    return 'Access denied! $message';
  }

  @override
  String errorBadRequest(String message) {
    return 'The server could not process the request. $message';
  }

  @override
  String errorNotFound(String message) {
    return 'Page not available. $message';
  }

  @override
  String errorConflict(String message) {
    return 'The request could not be completed due to a conflict. $message';
  }

  @override
  String errorPayloadTooLarge(String message) {
    return 'The request exceeds the server limits. $message';
  }

  @override
  String errorMakePayment(String message) {
    return 'This content is not available until payment is made. $message';
  }

  @override
  String errorServer(String message) {
    return 'The server is currently unavailable, please try again. $message';
  }

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get enterEmail => 'Enter email';

  @override
  String get rememberMyAccount => 'Remember my account';

  @override
  String get enter => 'Enter';

  @override
  String enterPasswordMinChars(int count) {
    return 'Enter a password of at least $count characters';
  }
}
