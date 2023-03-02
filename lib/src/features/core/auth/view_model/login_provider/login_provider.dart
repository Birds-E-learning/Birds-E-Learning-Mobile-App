import 'package:birds_learning_network/src/features/core/auth/model/repositories/auth_repository.dart';
import 'package:birds_learning_network/src/features/core/auth/model/request_model/login_model.dart';
import 'package:birds_learning_network/src/features/core/auth/model/response_model/login_response.dart';
import 'package:birds_learning_network/src/global_model/services/storage/secure_storage/user_details.dart';
import 'package:birds_learning_network/src/global_model/services/storage/shared_preferences/user_details.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/response_snack.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool _isClicked = false;
  bool _showPassword = false;
  bool _isChecked = false;
  final storage = UserSecureStorage();

  bool get isChecked => _isChecked;

  bool get showPassword => _showPassword;

  bool get isClicked => _isClicked;

  void onClick() {
    _isClicked = !_isClicked;
    notifyListeners();
  }

  void onChecked(value, username, password) async {
    _isChecked = value;
    await UserPreferences.setRememberUser(value);
    notifyListeners();
    if (_isChecked == true) {
      await storage.setPassword(password);
      await storage.setUsername(username);
    } else {
      await storage.setPassword("");
      await storage.setUsername("");
    }
  }

  void isCheckedValue() async {
    _isChecked = await UserPreferences.getRememberUser();
    notifyListeners();
  }

  void onIconClicked() {
    _showPassword = !_showPassword;
    notifyListeners();
  }

  Future userLogin(context, LoginModel data) async {
    LoginResponse response = await AuthRepository().getLoginResponse(data);
    onClick();
    if (response.responseCode == "00") {
      await UserPreferences.setUserFirstName(response.responseData!.firstName!);
      await UserPreferences.setUserData(response);
      await UserPreferences.setLoginStatus(true);
      await storage.setToken(response.responseData!.authToken!);
      showSnack(context, response.responseCode!, response.responseMessage!);
    } else {
      showSnack(context, response.responseCode!, response.responseMessage!);
    }
    notifyListeners();
  }

  Future<String> getUsername() async {
    String? username = await storage.getUsername();
    return username ?? "";
  }

  Future<String> getPassword() async {
    String? password = await storage.getPassword();
    return password ?? "";
  }
}
