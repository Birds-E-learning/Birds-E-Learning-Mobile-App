import 'dart:convert';

import 'package:birds_learning_network/src/features/core/auth/model/response_model/login_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static Future<bool> setLoginStatus(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool("status", value);
  }

  static Future<bool> getLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? status = prefs.getBool("status");
    return status ?? false;
  }

  static Future<bool> setUserFirstName(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString("firstName", name);
  }

  static Future<String> getUserFirstName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? name = prefs.getString("firstName");
    return name ?? "There";
  }

  static Future<bool> setUserPhoto(String photo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString("photo", photo);
  }

  static Future<String> getUserPhoto() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userPhoto = prefs.getString("photo");
    return userPhoto ?? "";
  }

  static Future<bool> setUserEmail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString("email", email);
  }

  static Future<String> getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userEmail = prefs.getString("email");
    return userEmail ?? "";
  }

  static Future<bool> setUserData(LoginResponse user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userData = jsonEncode(user.toJson());
    return await prefs.setString("userData", userData);
  }

  static Future<LoginResponse> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userData = prefs.getString("userData");
    return LoginResponse.fromJson(jsonDecode(userData!));
  }

  static Future<bool> setRememberUser(bool isCheck) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool("isCheck", isCheck);
  }

  static Future<bool> getRememberUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isCheck") ?? false;
  }

  static Future<bool> setReminderDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String now = DateTime.now().toIso8601String();
    return await prefs.setString("reminderDate", now);
  }

  static Future<DateTime?> getReminderDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? date = prefs.getString("reminderDate");
    return date != null ? DateTime.parse(date) : null;
  }
}
