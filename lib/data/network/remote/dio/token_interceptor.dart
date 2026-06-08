import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:yala/domain/preferences/preference.dart';

class TokenInterceptor extends Interceptor {
  final Preference preference;
  final PackageInfo packageInfo;

  TokenInterceptor(
    this.preference,
    this.packageInfo,
  );

  String _getOsName() {
    if (Platform.isAndroid) {
      return 'Android';
    }
    if (Platform.isIOS) {
      return 'Ios';
    }
    return 'unknown';
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    Future(() async {
      final accessToken = await preference.getAccessToken();
      options.headers.addAll({
        'Content-Type': 'application/json',
        'App-Version-Name': packageInfo.version,
        'App-Version-Code': packageInfo.buildNumber,
        'App-Os': _getOsName(),
        if (accessToken.isNotEmpty) 'Authorization': 'Bearer $accessToken',
      });
      if (kDebugMode) {
        debugPrint('TOKEN: $accessToken');
      }
      return handler.next(options);
    });
  }
}
