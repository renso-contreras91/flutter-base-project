import 'package:package_info_plus/package_info_plus.dart';
import 'package:yala/di/setup_locator.dart';

Future<void> instancePackageInfo() async {
  locator.registerSingletonAsync<PackageInfo>(
    () async {
      return PackageInfo.fromPlatform();
    },
  );
  await locator.isReady<PackageInfo>();
}
