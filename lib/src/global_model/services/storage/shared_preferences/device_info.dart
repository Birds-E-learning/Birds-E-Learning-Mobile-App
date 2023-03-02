import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DevicePreference {
  static Future getDeviceDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var deviceDetails = prefs.getString("device");
    return jsonDecode(deviceDetails ?? "");
  }

  static Future<bool> saveDeviceDetails(device) async {
    setDeviceId(device["id"]);
    final device_ = json.encode(device);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString("device", device_);
  }

  static Future<bool> setDeviceId(id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString("id", id);
  }

  static getDeviceId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? deviceId = prefs.getString("id");
    return deviceId;
  }

  // Future getIOSDetails() async {
  //   var data = await DeviceInfoPlugin().iosInfo;
  //   return {
  //     "name": data.name,
  //     "deviceName": "IOS",
  //     "device": data.model,
  //     "version": data.utsname.version,
  //     "release": data.utsname.release,
  //     "id": data.identifierForVendor,
  //     "systemVersion": data.systemVersion,
  //   };
  // }

  // Future getWebDetails() async {
  //   SharedPreferences prefs_ = await SharedPreferences.getInstance();
  //   final webDevice = prefs_.getString("web");
  //   return jsonDecode(webDevice!);
  // }

  // static Future<bool> setIosDetails(ios) async {
  //   final iosData = json.encode(ios);
  //   SharedPreferences pref_ = await SharedPreferences.getInstance();

  //   final setIos = pref_.setString("ios", iosData);
  //   return setIos;
  // }

  // static Future<bool> setWebDetails(web) async {
  //   final webData = json.encode(web);
  //   SharedPreferences pref_ = await SharedPreferences.getInstance();

  //   final setWeb = pref_.setString("web", webData);
  //   return setWeb;
  // }

  // Future getDeviceLocation() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final deviceLocation = prefs.getString("location");
  //   // print("GETTING LOCATION.....$deviceLocation");
  //   return jsonDecode(deviceLocation!);
  // }

  // static Future<bool> setUserLocation(location) async {
  //   SharedPreferences pref_ = await SharedPreferences.getInstance();
  //   final location_ = jsonEncode(location);
  //   final locationSet = pref_.setString("location", location_);
  //   return locationSet;
  // }
}
