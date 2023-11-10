import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceData{

  static Future<String?> saveDeviceInfo()async{
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.id;
    }else if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
     return iosDeviceInfo.identifierForVendor;
    }
    return null;
  }
}