import 'package:dio/dio.dart';
import 'package:yala/data/datasources/auth_datasource.dart';
import 'package:yala/data/datasources_impl/auth_datasource_impl.dart';
import 'package:yala/data/network/remote/dio/network_handler.dart';
import 'package:yala/di/setup_locator.dart';
import 'package:yala/domain/preferences/preference.dart';

void instanceDatasources() {
  locator.registerSingleton<AuthDatasource>(
    AuthDatasourceImpl(
      locator<Dio>(),
      locator<NetworkHandler>(),
      locator<Preference>(),
    ),
  );
}