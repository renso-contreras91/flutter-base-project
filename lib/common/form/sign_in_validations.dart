import 'package:yala/common/constants/app_constants.dart';
import 'package:yala/common/extension/string_extensions.dart';

abstract final class SignInValidations {
  static bool emailHasError(String? email) {
    if (email.isNullOrBlank) {
      return true;
    }
    return !email.isValidEmail();
  }

  static bool passwordHasError(String? password) {
    if (password.isNullOrBlank) {
      return true;
    }
    return password.orEmpty().length < AppConstants.MINIMUM_LENGTH_PASSWORD;
  }
}
