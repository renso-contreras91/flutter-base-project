// app_failure_ext.dart
import 'package:yala/domain/either/app_failure.dart';
import 'package:yala/domain/model/ui_text.dart';

extension AppFailureUiText on AppFailure {
  UiText toUiText() {
    return switch (this) {
      FailureNetwork(:final message) =>
        message.isEmpty ? StringResource(getMessage: (l10n) => l10n.errorNetwork) : DynamicString(message),

      FailureTimeout(:final message) =>
        message.isEmpty ? StringResource(getMessage: (l10n) => l10n.errorTimeout) : DynamicString(message),

      FailureSecureConnection(:final message) =>
        message.isEmpty ? StringResource(getMessage: (l10n) => l10n.errorSecureConnection) : DynamicString(message),

      FailureJobCancellation(:final message) =>
        message.isEmpty ? StringResource(getMessage: (l10n) => l10n.errorJobCancellation) : DynamicString(message),

      FailureDataNullError(:final message) =>
        message.isEmpty ? StringResource(getMessage: (l10n) => l10n.errorUnknown) : DynamicString(message),

      FailureNone(:final message) =>
        message.isEmpty ? StringResource(getMessage: (l10n) => l10n.errorEmptyResponse) : DynamicString(message),

      FailureLocal(:final getMessage, :final args) => StringResource(getMessage: getMessage, args: args),

      FailureUnauthorized(:final message, :final isBackendMessage) =>
        isBackendMessage
            ? DynamicString(message)
            : StringResource(getMessage: (l10n) => l10n.errorUnauthorized(message)),

      FailureForbidden(:final message, :final isBackendMessage) =>
        isBackendMessage ? DynamicString(message) : StringResource(getMessage: (l10n) => l10n.errorForbidden(message)),

      FailureBadRequest(:final message, :final isBackendMessage) =>
        isBackendMessage ? DynamicString(message) : StringResource(getMessage: (l10n) => l10n.errorBadRequest(message)),

      FailureNotFound(:final message, :final isBackendMessage) =>
        isBackendMessage ? DynamicString(message) : StringResource(getMessage: (l10n) => l10n.errorNotFound(message)),

      FailureConflict(:final message, :final isBackendMessage) =>
        isBackendMessage ? DynamicString(message) : StringResource(getMessage: (l10n) => l10n.errorConflict(message)),

      FailurePayloadTooLarge(:final message, :final isBackendMessage) =>
        isBackendMessage
            ? DynamicString(message)
            : StringResource(getMessage: (l10n) => l10n.errorPayloadTooLarge(message)),

      FailureMakePayment(:final message, :final isBackendMessage) =>
        isBackendMessage
            ? DynamicString(message)
            : StringResource(getMessage: (l10n) => l10n.errorMakePayment(message)),

      FailureDetected(:final message, :final isBackendMessage) =>
        isBackendMessage ? DynamicString(message) : StringResource(getMessage: (l10n) => l10n.errorServer(message)),

      FailureServer(:final message, :final isBackendMessage) =>
        isBackendMessage ? DynamicString(message) : StringResource(getMessage: (l10n) => l10n.errorServer(message)),
    };
  }
}