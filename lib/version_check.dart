import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter/material.dart';

class VersionCheckService {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> fetchRemoteConfig() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: Duration(seconds: 10),
      minimumFetchInterval: Duration.zero, // 테스트용, 배포 시 변경 가능
    ));

    await _remoteConfig.fetchAndActivate();
  }

  Future<bool> isUpdateRequired() async {
    await fetchRemoteConfig();

    // 최신 버전 가져오기
    String latestVersion = _remoteConfig.getString("force_update_version");

    // 현재 앱 버전 가져오기
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String currentVersion = packageInfo.version;

    return _isNewerVersion(latestVersion, currentVersion);
  }

  bool _isNewerVersion(String latest, String current) {
    List<int> latestParts = latest.split('.').map(int.parse).toList();
    List<int> currentParts = current.split('.').map(int.parse).toList();

    for (int i = 0; i < latestParts.length; i++) {
      if (currentParts.length <= i || latestParts[i] > currentParts[i]) {
        return true;
      } else if (latestParts[i] < currentParts[i]) {
        return false;
      }
    }
    return false;
  }
}
