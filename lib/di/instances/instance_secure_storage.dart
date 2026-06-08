import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:yala/data/local/secure/flutter_secure_storage.dart';
import 'package:yala/data/preferences/base_preference.dart';
import 'package:yala/data/preferences/base_preferences_impl.dart';
import 'package:yala/data/preferences/preferences_impl.dart';
import 'package:yala/di/setup_locator.dart';
import 'package:yala/domain/preferences/preference.dart';

Future<void> instanceSecureStorage() async {
  locator.registerSingleton<FlutterSecureStorage>(
    LocalSecureStorage().getInstanceFlutterSecureStorage(),
  );
  locator.registerSingleton<BasePreferences>(
    BasePreferencesImpl(
      locator<FlutterSecureStorage>(),
    ),
  );
  locator.registerSingleton<Preference>(
    PreferenceImpl(
      locator<BasePreferences>(),
    ),
  );
}
