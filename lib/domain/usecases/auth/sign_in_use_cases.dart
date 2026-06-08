
import 'package:yala/domain/either/result.dart';
import 'package:yala/domain/model/data_auth.dart';
import 'package:yala/domain/repositories/auth_repository.dart';

class SignInUseCase {
  AuthRepository repository;

  SignInUseCase(this.repository);

  Future<Result<DataAuth>> run({
    required String email,
    required String password
  }) => repository.signIn(
    email: email,
    password: password
  );
}
