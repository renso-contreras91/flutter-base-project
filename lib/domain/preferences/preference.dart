import 'package:yala/domain/model/user.dart';

abstract class Preference {
  Future<void> saveEmail({
    required String email,
  });

  Future<String> getEmail();

  Future<void> deleteEmail();

  Future<void> saveRememberAccount({
    required bool isChecked,
  });

  Future<bool> isRememberAccount();

  Future<void> saveUser({
    required User user,
  });

  Future<User?> getUser();

  Future<void> deleteUser();

  Future<void> saveAccessToken({
    required String token,
  });

  Future<String> getAccessToken();

  Future<void> deleteAccessToken();

  Future<void> saveRefreshToken({
    required String token,
  });

  Future<String> getRefreshToken();

  Future<void> deleteRefreshToken();
}
