import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:yala/data/preferences/base_preference.dart';

class BasePreferencesImpl implements BasePreferences {
  final FlutterSecureStorage flutterSecureStorage;

  BasePreferencesImpl(
    this.flutterSecureStorage,
  );

  @override
  Future<void> saveString({
    required String key,
    required String? value,
  }) {
    return flutterSecureStorage.write(
      key: key,
      value: value,
    );
  }

  @override
  Future<void> saveInt({
    required String key,
    required int value,
  }) {
    return flutterSecureStorage.write(
      key: key,
      value: '$value',
    );
  }

  @override
  Future<void> saveDouble({
    required String key,
    required double value,
  }) {
    return flutterSecureStorage.write(
      key: key,
      value: '$value',
    );
  }

  @override
  Future<void> saveBool({
    required String key,
    required bool value,
  }) {
    return flutterSecureStorage.write(
      key: key,
      value: '$value',
    );
  }

  @override
  Future<void> saveObject({
    required String key,
    required Map<String, dynamic> value,
  }) {
    final valueEncoded = json.encode(value);
    return flutterSecureStorage.write(
      key: key,
      value: valueEncoded,
    );
  }

  @override
  Future<String> readString({
    required String key,
    String def = '',
  }) async {
    final value = await flutterSecureStorage.read(
      key: key,
    );
    return value ?? def;
  }

  @override
  Future<int> readInt({
    required String key,
    int def = 0,
  }) async {
    final value = await flutterSecureStorage.read(
      key: key,
    );
    if (value == null || value.isEmpty) {
      return def;
    }
    return int.tryParse(value) ?? def;
  }

  @override
  Future<double> readDouble({
    required String key,
    double def = 0.0,
  }) async {
    final value = await flutterSecureStorage.read(
      key: key,
    );
    if (value == null || value.isEmpty) {
      return def;
    }
    return double.tryParse(value) ?? def;
  }

  @override
  Future<bool> readBool({
    required String key,
    bool def = false,
  }) async {
    final value = await flutterSecureStorage.read(
      key: key,
    );
    if (value == null || value.isEmpty) {
      return def;
    }
    return value.toLowerCase() == 'true';
  }

  @override
  Future<Map<String, dynamic>?> readObject({
    required String key,
  }) async {
    final value = await flutterSecureStorage.read(
      key: key,
    );
    if (value == null || value.isEmpty) {
      return null;
    }
    return jsonDecode(value) as Map<String, dynamic>;
  }

  @override
  Future<void> delete({
    required String key,
  }) {
    return flutterSecureStorage.delete(
      key: key,
    );
  }

  @override
  Future<bool> contains({
    required String key,
  }) {
    return flutterSecureStorage.containsKey(
      key: key,
    );
  }
}
