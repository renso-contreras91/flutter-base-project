import 'package:yala/domain/either/result.dart';
import 'package:yala/domain/model/data_auth.dart';

abstract class AuthDatasource {

  Future<Result<DataAuth>> signIn({
    required String email,
    required String password,
  });
}