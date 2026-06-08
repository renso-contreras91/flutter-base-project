import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:yala/common/routes/app_routes.dart';
import 'package:yala/common/theme/app_theme.dart';
import 'package:yala/config/build/build_constants.dart';
import 'package:yala/config/firebase/crashlytics/crashlytics_config.dart';
import 'package:yala/di/setup_locator.dart';
import 'package:yala/common/enum/enums.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:yala/l10n/app_localizations.dart';
import 'config/firebase/firebase_options_prod.dart';
import 'config/firebase/firebase_options_dev.dart';

void mainApp({
  required FlavorEnum flavorEnum,
}) async {
  WidgetsFlutterBinding.ensureInitialized();
  final options = flavorEnum == FlavorEnum.PROD
      ? DefaultFirebaseOptionsProd.currentPlatform
      : DefaultFirebaseOptionsDev.currentPlatform;
  await Firebase.initializeApp(options: options);
  await CrashlyticsConfig.init(flavorEnum);
  await dotenv.load(fileName: BuildConstants.env);
  await setupLocator(
    flavorEnum: flavorEnum,
  );
  if (kDebugMode) {
    await locator<FlutterSecureStorage>().deleteAll();
  }
  runApp(MyApp(flavorEnum: flavorEnum));
}

class MyApp extends StatelessWidget {
  final FlavorEnum flavorEnum;

  const MyApp({
    super.key,
    required this.flavorEnum,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      title: flavorEnum.appName,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
    );
  }
}
