import 'package:birds_learning_network/src/features/core/auth/model/request_model/auth_consent_model.dart';
import 'package:birds_learning_network/src/features/core/auth/model/request_model/auth_model.dart';
import 'package:birds_learning_network/src/features/core/auth/model/request_model/auto_login_model.dart';
import 'package:birds_learning_network/src/features/core/auth/model/request_model/login_model.dart';
import 'package:birds_learning_network/src/features/core/auth/model/request_model/otp_model.dart';
import 'package:birds_learning_network/src/features/core/auth/model/request_model/reset_model.dart';
import 'package:birds_learning_network/src/features/core/auth/model/request_model/sign_up_model.dart';
import 'package:birds_learning_network/src/features/core/auth/model/response_model/auth_response.dart';
import 'package:birds_learning_network/src/features/core/auth/model/response_model/login_response.dart';
import 'package:birds_learning_network/src/features/core/auth/model/response_model/otp_response.dart';
import 'package:birds_learning_network/src/features/core/auth/model/response_model/reset_response.dart';
import 'package:birds_learning_network/src/features/core/auth/model/response_model/sign_up_response.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_header.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_service.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_url.dart';

class AuthRepository extends NetworkService with BaseHeaders, BaseUrl {
  Future<SignUpResponse> getSignUpResponse(SignUpModel body, context) async {
    dynamic response =
        await postRequest(signUp, header, body.toJson(), context);
    SignUpResponse responseData = SignUpResponse.fromJson(response);
    return responseData;
  }

  Future<LoginResponse> getLoginResponse(LoginModel body, context) async {
    dynamic response = await postRequest(login, header, body.toJson(), context);
    LoginResponse responseData = LoginResponse.fromJson(response);
    return responseData;
  }

  Future<LoginResponse> getAutoLoginResponse(
      AutomaticLoginModel body, context) async {
    dynamic response =
        await postRequest(autoLogin, header, body.toJson(), context);
    LoginResponse responseData = LoginResponse.fromJson(response);
    return responseData;
  }

  Future<OtpResponse> getOtpResponse(
      bool isRegistered, OtpModel body, context) async {
    String url = isRegistered ? verifyOtp : validateResetOtp;
    print(url);
    dynamic response = await postRequest(url, header, body.toJson(), context);
    OtpResponse responseData = OtpResponse.fromJson(response);
    return responseData;
  }

  // Future<

  Future<OtpResponse> getResendOtpResponse(
      String service, String email, context) async {
    String url = service == "Resend" ? "$resendOtp$email" : "$resetOtp$email";
    print(url);
    dynamic response = await getRequest(url, header, context);
    OtpResponse responseData = OtpResponse.fromJson(response);
    return responseData;
  }

  Future<OAuthResponse> getOauthResponse(AuthModel data, context) async {
    dynamic response =
        await postRequest(oAuthUrl, header, data.toJson(), context);
    OAuthResponse responseData = OAuthResponse.fromJson(response);
    return responseData;
  }

  Future<ResetResponse> getResetPasswordResponse(
      ResetModel data, context) async {
    dynamic response =
        await postRequest(resetPassword, header, data.toJson(), context);
    ResetResponse responseData = ResetResponse.fromJson(response);
    return responseData;
  }

  Future<LoginResponse> getConsentResponse(
      AuthConsentModel data, context) async {
    dynamic response =
        await postRequest(oAuthValidation, header, data.toJson(), context);
    LoginResponse responseData = LoginResponse.fromJson(response);
    return responseData;
  }
}
