import 'package:get_it/get_it.dart';
import 'package:yala/di/instances/instance_connection.dart';
import 'package:yala/di/instances/instance_datasources.dart';
import 'package:yala/di/instances/instance_network.dart';
import 'package:yala/di/instances/instance_package_info.dart';
import 'package:yala/di/instances/instance_repositories.dart';
import 'package:yala/di/instances/instance_secure_storage.dart';
import 'package:yala/di/instances/instance_usecases.dart';
import 'package:yala/common/enum/enums.dart';

final locator = GetIt.instance;

Future<void> setupLocator({
  required FlavorEnum flavorEnum,
}) async {
  await instancePackageInfo();
  await instanceSecureStorage();
  instanceConnection();
  instanceNetwork(flavorEnum);
  instanceDatasources();
  instanceRepositories();
  instanceUseCases();
}
