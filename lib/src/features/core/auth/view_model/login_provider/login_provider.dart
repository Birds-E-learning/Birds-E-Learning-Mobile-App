import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/core/auth/model/repositories/auth_repository.dart';
import 'package:birds_learning_network/src/features/core/auth/model/request_model/auto_login_model.dart';
import 'package:birds_learning_network/src/features/core/auth/model/request_model/login_model.dart';
import 'package:birds_learning_network/src/features/core/auth/model/response_model/login_response.dart';
import 'package:birds_learning_network/src/features/core/auth/view/sign_in.dart';
import 'package:birds_learning_network/src/features/core/settings/view/filter/filter_screen.dart';
import 'package:birds_learning_network/src/global_model/services/storage/secure_storage/user_details.dart';
import 'package:birds_learning_network/src/global_model/services/storage/shared_preferences/user_details.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/response_snack.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  bool _isClicked = false;
  bool _showPassword = false;
  bool _isChecked = false;
  bool _completeClicked = false;
  LoginModel _loginData = LoginModel();
  final storage = UserSecureStorage();

  bool get isChecked => _isChecked;

  bool get completeClicked => _completeClicked;

  bool get showPassword => _showPassword;

  bool get isClicked => _isClicked;

  LoginModel get loginData => _loginData;

  void onClick() {
    _isClicked = !_isClicked;
    notifyListeners();
  }

  void onCompleteClick() {
    _completeClicked = !_completeClicked;
    notifyListeners();
  }

  void getLoginData(LoginModel data) {
    _loginData = data;
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

  Future userLogin(context, LoginModel data, bool autoLogin) async {
    try {
      LoginResponse response =
          await AuthRepository().getLoginResponse(data, context);
      onClick();
      if (response.responseCode == "00") {
        await UserPreferences.setUserFirstName(
            response.responseData!.firstName!);
        await UserPreferences.setUserData(response);
        await UserPreferences.setLoginStatus(true);
        await storage.setToken(response.responseData!.authToken!);
        await storage.setUserData(response);
        RoutingService.pushAndRemoveAllRoute(context, const FilterScreen());
      } else {
        showSnack(context, response.responseCode!, response.responseMessage!);
      }
      notifyListeners();
    } catch (e) {
      print(e);
      autoLogin ? onCompleteClick() : onClick();
      showSnack(context, "02", "Network TimedOut");
    }
  }

  Future<String> getUsername() async {
    String? username = await storage.getUsername();
    return username ?? "";
  }

  Future<String> getPassword() async {
    String? password = await storage.getPassword();
    return password ?? "";
  }

  Future autoLogin(AutomaticLoginModel data, context) async {
    try {
      LoginResponse response =
          await AuthRepository().getAutoLoginResponse(data, context);
      if (response.responseCode == "00") {
        await UserPreferences.setUserFirstName(
            response.responseData!.firstName!);
        await UserPreferences.setUserData(response);
        await storage.setToken(response.responseData!.authToken!);
        await storage.setUserData(response);
        RoutingService.pushReplacementRouting(context, const FilterScreen());
      } else {
        RoutingService.pushReplacementRouting(
            context, const LoginScreen(firstTime: false));
      }
      notifyListeners();
    } catch (e) {
      print(e);
      // showSnack(context, "02", "Network TimedOut");
    }
  }
}
