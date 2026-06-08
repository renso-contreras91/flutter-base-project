import 'package:dio/dio.dart';
import 'package:yala/data/datasources/auth_datasource.dart';
import 'package:yala/data/model/data_auth_dto.dart';
import 'package:yala/data/network/remote/dio/network_handler.dart';
import 'package:yala/data/network/remote/endpoints/endpoints.dart';
import 'package:yala/domain/either/result.dart';
import 'package:yala/domain/model/data_auth.dart';
import 'package:yala/domain/preferences/preference.dart';

class AuthDatasourceImpl extends AuthDatasource {
  final Dio dio;
  final NetworkHandler networkHandler;
  final Preference preference;

  AuthDatasourceImpl(
    this.dio,
    this.networkHandler,
    this.preference,
  );

  @override
  Future<Result<DataAuth>> signIn({
    required String email,
    required String password,
  }) async {
    final result = await networkHandler.handleServerResponse(
       task: () => dio.post<Map<String, dynamic>>(
        AuthApi.signIn(),
        data: {
          'email': email,
          'password': password,
        },
      ),
      fromJsonT :(json) {
        return json != null ? DataAuthDto.fromJson(json) : null;
      },
    );

    switch (result) {
      case Success(:final response):
        return Success(response?.data?.toDomain());
      case Failure(appFailure:final exception):
        return Failure(exception);
    }
  }
}
