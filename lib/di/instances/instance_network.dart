import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:yala/data/network/remote/dio/dio_client.dart';
import 'package:yala/data/network/remote/dio/network_handler.dart';
import 'package:yala/data/network/remote/dio/token_interceptor.dart';
import 'package:yala/data/network/remote/utils/interfaces/network_info.dart';
import 'package:yala/di/setup_locator.dart';
import 'package:yala/domain/preferences/preference.dart';
import 'package:yala/common/enum/enums.dart';

void instanceNetwork(FlavorEnum flavorEnum) {
  final baseUrl = flavorEnum == FlavorEnum.PROD
      ? dotenv.env['BASE_URL_PROD']!
      : dotenv.env['BASE_URL_DEV']!;

  locator.registerSingleton<TokenInterceptor>(
    TokenInterceptor(
      locator<Preference>(),
      locator<PackageInfo>(),
    ),
  );
  locator.registerSingleton<NetworkHandler>(
    NetworkHandler(
      locator<NetworkInfo>(),
    ),
  );
  if (!locator.isRegistered<Dio>()) {
    locator.registerSingleton<Dio>(
      DioClient().getDio(
        baseUrl: baseUrl,
        tokenInterceptor: locator<TokenInterceptor>(),
      ),
    );
  }
}
