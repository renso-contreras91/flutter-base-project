import 'package:yala/data/preferences/base_preference.dart';
import 'package:yala/domain/model/user.dart';
import 'package:yala/domain/preferences/preference.dart';

class PreferenceImpl implements Preference {
  static const String _preferenceAccessToken = '_PREFERENCE_ACCESS_TOKEN';
  static const String _preferenceRefreshToken = "_PREFERENCE_REFRESH_TOKEN";
  static const String _preferenceUser = '_PREFERENCE_USER';
  static const String _preferenceEmail = "_PREFERENCE_EMAIL";
  static const String _preferenceIsRememberAccount = "_PREFERENCE_IS_REMEMBER_ACCOUNT";

  BasePreferences basePreferences;

  PreferenceImpl(
    this.basePreferences,
  );

  @override
  Future<void> saveEmail({
    required String email,
  }) {
    return basePreferences.saveString(
      key: _preferenceEmail,
      value: email,
    );
  }

  @override
  Future<String> getEmail() {
    return basePreferences.readString(
      key: _preferenceEmail,
    );
  }

  @override
  Future<void> deleteEmail() {
    return basePreferences.delete(
      key: _preferenceEmail,
    );
  }

  @override
  Future<void> saveRememberAccount({
    required bool isChecked,
  }) {
    return basePreferences.saveBool(
      key: _preferenceIsRememberAccount,
      value: isChecked,
    );
  }

  @override
  Future<bool> isRememberAccount() {
    return basePreferences.readBool(
      key: _preferenceIsRememberAccount,
    );
  }

  @override
  Future<void> saveUser({
    required User user,
  }) {
    return basePreferences.saveObject(
      key: _preferenceUser,
      value: user.toJson(),
    );
  }

  @override
  Future<User?> getUser() async {
    final value = await basePreferences.readObject(
      key: _preferenceUser,
    );
    return value != null ? User.fromJson(value) : null;
  }

  @override
  Future<void> deleteUser() {
    return basePreferences.delete(
      key: _preferenceUser,
    );
  }

  @override
  Future<void> saveAccessToken({
    required String token,
  }) {
    return basePreferences.saveString(
      key: _preferenceAccessToken,
      value: token,
    );
  }

  @override
  Future<String> getAccessToken() {
    return basePreferences.readString(
      key: _preferenceAccessToken,
    );
  }

  @override
  Future<void> deleteAccessToken() {
    return basePreferences.delete(
      key: _preferenceAccessToken,
    );
  }

  @override
  Future<void> saveRefreshToken({
    required String token,
  }) {
    return basePreferences.saveString(
      key: _preferenceRefreshToken,
      value: token,
    );
  }

  @override
  Future<String> getRefreshToken() {
    return basePreferences.readString(
      key: _preferenceRefreshToken,
    );
  }

  @override
  Future<void> deleteRefreshToken() {
    return basePreferences.delete(
      key: _preferenceRefreshToken,
    );
  }
}
