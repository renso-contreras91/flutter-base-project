import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:yala/data/network/remote/utils/impl/network_info_impl.dart';
import 'package:yala/data/network/remote/utils/interfaces/network_info.dart';
import 'package:yala/di/setup_locator.dart';

void instanceConnection() {
  locator.registerSingleton<Connectivity>(
    Connectivity(),
  );
  locator.registerSingleton<NetworkInfo>(
    NetworkInfoImpl(
      locator<Connectivity>(),
    ),
  );
}
