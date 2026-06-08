
import 'package:yala/data/network/remote/utils/interfaces/network_info.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfoImpl extends NetworkInfo {
 final Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> isConnected() async {
    final results = await connectivity.checkConnectivity();
    return results.any(
      (result) => result != ConnectivityResult.none,
    );
  }
}