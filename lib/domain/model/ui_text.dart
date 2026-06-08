import 'package:yala/l10n/app_localizations.dart';

sealed class UiText {
  const UiText();

  String resolve(AppLocalizations l10n) {
    if (this is DynamicString) {
      return (this as DynamicString).value;
    } else {
      return (this as StringResource).getMessage(l10n);
    }
  }

  /*
  String resolve(AppLocalizations l10n) {
    return switch (this) {
      DynamicString(:final value) => value,
      StringResource(:final getMessage) => getMessage(l10n),
    };
  }
  */
}

class DynamicString extends UiText {
  final String value;
  const DynamicString(this.value);
}

class StringResource extends UiText {
  final String Function(AppLocalizations) getMessage;
  final List<Object> args;
  
  const StringResource({
    required this.getMessage,
    this.args = const [],
  });
}