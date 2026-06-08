import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalSecureStorage {
  FlutterSecureStorage getInstanceFlutterSecureStorage() {
    AndroidOptions getAndroidOptions() => const AndroidOptions(
      storageCipherAlgorithm: StorageCipherAlgorithm.AES_GCM_NoPadding,
    );

    return FlutterSecureStorage(
      aOptions: getAndroidOptions(),
    );
  }
}