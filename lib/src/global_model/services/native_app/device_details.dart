import 'dart:io';

import 'package:birds_learning_network/src/global_model/apis/app_exception.dart';
import 'package:birds_learning_network/src/global_model/services/storage/shared_preferences/device_info.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';

Future getDeviceDetails() async {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  try {
    if (Platform.isAndroid) {
      AndroidDeviceInfo build = await deviceInfoPlugin.androidInfo;

      Map<String, String> android = {
        "model": build.model.toString(),
        "version": build.version.release.toString(),
        "id": build.id.toString(),
        "deviceName": "ANDROID".toString(),
        "name": build.manufacturer.toString()
      };
      DevicePreference.saveDeviceDetails(android);
    } else if (Platform.isIOS) {
      var data = await deviceInfoPlugin.iosInfo;
      Map<String, dynamic> ios = {
        "name": data.name.toString(),
        "deviceName": "IOS",
        "model": data.model.toString(),
        "version": data.utsname.version.toString(),
        "id": data.identifierForVendor.toString(),
      };
      DevicePreference.saveDeviceDetails(ios);
    } else {
      WebBrowserInfo webBrowserInfo = await deviceInfoPlugin.webBrowserInfo;
      Map<String, String> webInfo = {
        "deviceName": webBrowserInfo.platform!,
        "model": webBrowserInfo.userAgent!,
        "version": webBrowserInfo.appVersion!,
        "name": webBrowserInfo.browserName.name,
        "id": webBrowserInfo.product!,
      };
      DevicePreference.saveDeviceDetails(webInfo);
    }
  } on PlatformException {
    throw FetchDataException("Failed to get Device ID");
  }
}
