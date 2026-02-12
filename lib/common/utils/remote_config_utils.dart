import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class RemoteConfig {
  final String newVersion;
  final bool isForceUpdate;
  final bool enableUpdate;

  RemoteConfig({
    required this.newVersion,
    required this.isForceUpdate,
    required this.enableUpdate,
  });
}
 
class RemoteConfigUtil {
  static Future<RemoteConfig?> fetchConfig() async {
    try {
      final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: Duration.zero,
        ),
      );
      await remoteConfig.fetchAndActivate();

      return RemoteConfig(
        newVersion: remoteConfig.getString('app_version'),
        isForceUpdate: remoteConfig.getBool('force_update'),
        enableUpdate: remoteConfig.getBool('enable_update'),
      );
    } catch (e) {
      debugPrint('Remote config fetch failed: $e');
      return null;
    }
  }
}
