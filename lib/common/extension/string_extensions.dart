
import 'package:yala/common/constants/app_constants.dart';

extension StringExtension on String? {
  bool get isNull => this == null;

  bool get isNullOrEmpty => isNull || this?.isEmpty == true;

  bool get isNullOrBlank => isNull || this?.isBlank() == true;

  bool isBlank() => isNull || this?.trim().isEmpty == true;

  bool isNotBlank() => this != null && this?.trim().isNotEmpty == true;

  String orEmpty({
    String def = AppConstants.EMPTY_STRING,
  }) {
    return isNullOrBlank ? def : this!;
  }

  bool isValidEmail() {
    final emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    return emailRegExp.hasMatch(this ?? '');
  }
}