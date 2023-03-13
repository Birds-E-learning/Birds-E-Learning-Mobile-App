import 'dart:convert';

import 'package:birds_learning_network/src/features/core/auth/model/response_model/login_response.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  final storage = const FlutterSecureStorage();

  final String _tokenKey = "token";
  final String _passwordKey = "password";
  final String _usernameKey = "username";
  // final String _isCheckKey = "isCheck";
  final String _userDataKey = "userData";

  Future setToken(String token) async {
    await storage.write(key: _tokenKey, value: token);
  }

  Future setPassword(String password) async {
    await storage.write(key: _passwordKey, value: password);
  }

  Future setUserData(LoginResponse userData) async {
    await setToken(userData.responseData!.authToken ?? "");
    await storage.write(key: _userDataKey, value: jsonEncode(userData));
  }

  Future setUsername(String username) async {
    await storage.write(key: _usernameKey, value: username);
  }

  Future<String> getToken() async {
    return await storage.read(key: _tokenKey) ?? "";
  }

  Future<String?> getPassword() async {
    return await storage.read(key: _passwordKey);
  }

  Future<String?> getUsername() async {
    return await storage.read(key: _usernameKey);
  }

  Future<LoginResponse> getUserData() async {
    String? value = await storage.read(key: _userDataKey);
    LoginResponse response = LoginResponse.fromJson(jsonDecode(value!));

    return response;
  }
}
