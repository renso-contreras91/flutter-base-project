// config/crashlytics/crashlytics_config.dart
import 'dart:ui';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:yala/common/enum/enums.dart';

class CrashlyticsConfig {
  CrashlyticsConfig._();

  static Future<void> init(FlavorEnum flavorEnum) async {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(
      flavorEnum == FlavorEnum.PROD,
    );

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }
}
