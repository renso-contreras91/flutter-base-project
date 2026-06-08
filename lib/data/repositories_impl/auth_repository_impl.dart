import 'package:yala/data/datasources/auth_datasource.dart';
import 'package:yala/domain/either/result.dart';
import 'package:yala/domain/model/data_auth.dart';
import 'package:yala/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource authDatasource;

  AuthRepositoryImpl(this.authDatasource);

  @override
  Future<Result<DataAuth>> signIn({
    required String email,
    required String password,
  }) {
    return authDatasource.signIn(
      email: email,
      password: password,
    );
  }
}
