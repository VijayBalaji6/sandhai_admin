import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersionInfo {
  final String version;
  final String buildNumber;

  AppVersionInfo({required this.version, required this.buildNumber});
}

class AppVersionHelper {
  static Future<AppVersionInfo?> getAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    debugPrint("version: ${packageInfo.version}");
    return AppVersionInfo(
      version: packageInfo.version,
      buildNumber: packageInfo.buildNumber,
    );
  }

  static Future<bool> checkVersionUpdate(String? newVersion) async {
    final String? currentVersion = await getAppVersion().then(
      (AppVersionInfo? value) => value?.version,
    );
    if (currentVersion == null || newVersion == null) return false;
    return currentVersion.compareTo(newVersion) < 0;
  }
}
