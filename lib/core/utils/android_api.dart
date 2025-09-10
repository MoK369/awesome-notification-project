import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

abstract class AndroidApiProvider {
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
  static Future<int> getCurrentAndroidApi() async {
    final androidInfo = await _deviceInfoPlugin.androidInfo;
    return androidInfo.version.sdkInt;
  }

  static Future<bool> isAndroid12OrHigher() async {
    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfoPlugin.androidInfo;
      return androidInfo.version.sdkInt >= 31;
    }
    return false;
  }
}
