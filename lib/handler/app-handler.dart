import 'package:package_info_plus/package_info_plus.dart';

Future<PackageInfo> getAppHandler() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo;
}
