import 'package:yala/l10n/app_localizations.dart';

sealed class AppFailure implements Exception {
  final String message;

  const AppFailure({this.message = ''});

  @override
  String toString() => message;
}

class FailureNetwork extends AppFailure {
  const FailureNetwork({
    super.message,
  });
}

class FailureUnauthorized extends AppFailure {
  final bool isBackendMessage;
  const FailureUnauthorized({
    super.message,
    this.isBackendMessage = false,
  });
}

class FailureForbidden extends AppFailure {
  final bool isBackendMessage;
  const FailureForbidden({
    super.message,
    this.isBackendMessage = false,
  });
}

class FailureServer extends AppFailure {
  final bool isBackendMessage;
  const FailureServer({
    super.message,
    this.isBackendMessage = false,
  });
}

class FailureTimeout extends AppFailure {
  const FailureTimeout({
    super.message,
  });
}

class FailureDataNullError extends AppFailure {
  const FailureDataNullError({
    super.message,
  });
}

class FailureSecureConnection extends AppFailure {
  const FailureSecureConnection({
    super.message,
  });
}

class FailureDetected extends AppFailure {
  final bool isBackendMessage;
  const FailureDetected({
    super.message,
    this.isBackendMessage = false,
  });
}

class FailureJobCancellation extends AppFailure {
  const FailureJobCancellation({
    super.message,
  });
}

class FailureNone extends AppFailure {
  const FailureNone({
    super.message,
  });
}

class FailureBadRequest extends AppFailure {
  final bool isBackendMessage;
  const FailureBadRequest({
    super.message,
    this.isBackendMessage = false,
  });
}

class FailureNotFound extends AppFailure {
  final bool isBackendMessage;
  const FailureNotFound({
    super.message,
    this.isBackendMessage = false,
  });
}

class FailurePayloadTooLarge extends AppFailure {
  final bool isBackendMessage;
  const FailurePayloadTooLarge({
    super.message,
    this.isBackendMessage = false,
  });
}

class FailureMakePayment extends AppFailure {
  final bool isBackendMessage;
  const FailureMakePayment({
    super.message,
    this.isBackendMessage = false,
  });
}

class FailureConflict extends AppFailure {
  final bool isBackendMessage;
  const FailureConflict({
    super.message,
    this.isBackendMessage = false,
  });
}

class FailureLocal extends AppFailure {
  final String Function(AppLocalizations) getMessage;
  final List<Object> args;
  const FailureLocal({
    required this.getMessage,
    this.args = const [],
    super.message,
  });
}
