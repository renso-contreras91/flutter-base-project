abstract class BasePreferences {
  Future<void> saveString({
    required String key,
    required String? value,
  });

  Future<void> saveInt({
    required String key,
    required int value,
  });

  Future<void> saveDouble({
    required String key,
    required double value,
  });

  Future<void> saveBool({
    required String key,
    required bool value,
  });

  Future<void> saveObject({
    required String key,
    required Map<String, dynamic> value,
  });

  Future<String> readString({
    required String key,
    String def = '',
  });

  Future<int> readInt({
    required String key,
    int def = 0,
  });

  Future<double> readDouble({
    required String key,
    double def = 0.0,
  });

  Future<bool> readBool({
    required String key,
    bool def = false,
  });

  Future<dynamic> readObject({
    required String key,
  });

  Future<void> delete({
    required String key,
  });

  Future<bool> contains({
    required String key,
  });
}
