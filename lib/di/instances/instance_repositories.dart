import 'package:yala/data/datasources/auth_datasource.dart';
import 'package:yala/data/repositories_impl/auth_repository_impl.dart';
import 'package:yala/di/setup_locator.dart';
import 'package:yala/domain/repositories/auth_repository.dart';

void instanceRepositories() {
   locator.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(
      locator<AuthDatasource>(),
    ),
  );
}
