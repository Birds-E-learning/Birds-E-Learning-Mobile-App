import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/core/auth/model/repositories/auth_repository.dart';
import 'package:birds_learning_network/src/features/core/auth/model/request_model/auth_consent_model.dart';
import 'package:birds_learning_network/src/features/core/auth/model/request_model/auth_model.dart';
import 'package:birds_learning_network/src/features/core/auth/model/request_model/login_model.dart';
import 'package:birds_learning_network/src/features/core/auth/model/request_model/sign_up_model.dart';
import 'package:birds_learning_network/src/features/core/auth/model/response_model/auth_response.dart';
import 'package:birds_learning_network/src/features/core/auth/model/response_model/json_response.dart';
import 'package:birds_learning_network/src/features/core/auth/model/response_model/login_response.dart';
import 'package:birds_learning_network/src/features/core/auth/model/response_model/sign_up_response.dart';
import 'package:birds_learning_network/src/features/core/auth/view/web_view.dart';
import 'package:birds_learning_network/src/features/core/settings/view/filter/filter_screen.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_service.dart';
import 'package:birds_learning_network/src/global_model/services/storage/secure_storage/user_details.dart';
import 'package:birds_learning_network/src/global_model/services/storage/shared_preferences/user_details.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/response_snack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OAuthProvider extends ChangeNotifier {
  bool _webviewCompleted = false;
  bool _facebookClicked = false;
  bool _googleClicked = false;
  bool _appleClicked = false;
  String _serviceProvider = "FACEBOOK";
  final WebViewController controller = WebViewController();
  Map _userData = {};
  bool isDone = false;
  String url = "";
  String _deviceId = "";
  String _validationType = "SIGNUP";
  final storage = UserSecureStorage();
  AuthRepository repository = AuthRepository();

  bool get webviewCompleted => _webviewCompleted;
  bool get facebookClicked => _facebookClicked;
  bool get googleClicked => _googleClicked;
  bool get appleClicked => _appleClicked;
  String get serviceProvider => _serviceProvider;
  String get validationType => _validationType;

  void onFacebookClick() {
    _facebookClicked = !_facebookClicked;
    notifyListeners();
  }

  void onGoogleClicked() {
    _googleClicked = !_googleClicked;
    notifyListeners();
  }

  void onAppleClicked() {
    _appleClicked = !_appleClicked;
    notifyListeners();
  }

  void onWebviewCompleted() {
    _webviewCompleted = !_webviewCompleted;
    notifyListeners();
  }

  Future facebookAuth(String deviceId, context) async {
    try {
      LoginResult res = await FacebookAuth.instance
          .login(permissions: ["email", "public_profile"]);
      // print(res.accessToken!.token);
      // print("status === > ${res.status}");
      // print(res);
      switch (res.status) {
        case LoginStatus.success:
          _userData = await FacebookAuth.instance.getUserData();
          List<String> names = _userData["name"].toString().split(" ");
          _userData["firstName"] = names[0];
          _userData["lastName"] = names[names.length - 1];
          notifyListeners();
          SignUpModel data = SignUpModel(
            firstName: _userData["firstName"],
            lastName: _userData["lastName"],
            deviceId: deviceId,
            userRoles: [],
            photo: _userData["picture"]["data"]["url"],
            username: _userData["email"] ?? "",
            emailAddress: _userData["email"] ?? "",
            signupBy: "FACEBOOK",
          );
          SignUpResponse response =
              await repository.getSignUpResponse(data, context);
          if (response.responseCode == "00") {
            LoginModel body = LoginModel(
                loginBy: "FACEBOOK",
                email: _userData["email"],
                deviceId: deviceId);
            LoginResponse loginResponse =
                await repository.getLoginResponse(body, context);
            if (loginResponse.responseCode == "00") {
              await UserPreferences.setUserFirstName(
                  loginResponse.responseData!.firstName!);
              await UserPreferences.setUserData(loginResponse);
              await UserPreferences.setLoginStatus(true);
              await storage.setToken(loginResponse.responseData!.authToken!);
              await storage.setUserData(loginResponse);
              facebookClicked ? onFacebookClick() : null;
              RoutingService.pushAndRemoveAllRoute(
                  context, const FilterScreen());
            } else {
              facebookClicked ? onFacebookClick() : null;
              showSnack(context, loginResponse.responseCode!,
                  loginResponse.responseMessage!);
            }
          } else {
            facebookClicked ? onFacebookClick() : null;
            showSnack(
                context, response.responseCode!, response.responseMessage!);
          }
          break;
        case LoginStatus.cancelled:
          break;
        case LoginStatus.failed:
          showSnack(context, "02", res.message!);
          break;
        default:
          break;
      }

      facebookClicked ? onFacebookClick() : null;

      notifyListeners();
    } catch (e) {
      print(e);
      facebookClicked ? onFacebookClick() : null;
      showSnack(context, "02", "Facebook auth failed!");
    }
    notifyListeners();
  }

  Future oAuthCall(AuthModel body, String validationType, context) async {
    try {
      _serviceProvider = body.authServiceProvider!;
      _validationType = validationType;
      _deviceId = body.deviceId!;
      notifyListeners();
      OAuthResponse response =
          await AuthRepository().getOauthResponse(body, context);
      if (response.responseCode == "00") {
        isDone = true;
        url = response.responseData!.authorizationConsentUrl!;
        notifyListeners();
        checkServiceClicked(_serviceProvider);
        RoutingService.pushRouting(context,
            WebView(data: body, url: url, serviceProvider: _serviceProvider));
      } else {
        checkServiceClicked(_serviceProvider);
        showSnack(context, response.responseCode!, response.responseMessage!);
      }
    } catch (e) {
      checkServiceClicked(_serviceProvider);
      showSnack(context, "02", "Network TimedOut");
    }
  }

  void checkServiceClicked(String serviceProvider_) {
    if (serviceProvider_ == "FACEBOOK") {
      onFacebookClick();
    } else if (serviceProvider_ == "GOOGLE") {
      onGoogleClicked();
    } else if (serviceProvider_ == "APPLE") {
      onAppleClicked();
    }
  }

  Future consentValidationRespponse(String url, context) async {
    try {
      _webviewCompleted = false;
      notifyListeners();
      dynamic stateResponse =
          await NetworkService().getRequest(url, {}, context);
      AuthJsonModel json = AuthJsonModel.fromJson(stateResponse);
      AuthConsentModel data = AuthConsentModel(
          consentCode: json.code,
          state: json.state,
          authServiceProvider: _serviceProvider,
          deviceId: _deviceId,
          oauthValidationType: validationType);
      LoginResponse response =
          await AuthRepository().getConsentResponse(data, context);

      if (response.responseCode == "00") {
        await UserPreferences.setUserFirstName(
            response.responseData!.firstName!);
        await UserPreferences.setUserData(response);
        await UserPreferences.setLoginStatus(true);
        await storage.setToken(response.responseData!.authToken!);
        await storage.setUserData(response);
        onWebviewCompleted();
      } else {
        showSnack(context, response.responseCode!, response.responseMessage!);
      }
      notifyListeners();
    } catch (e) {
      showSnack(context, "02", "Network TimedOut");
    }
  }
}
