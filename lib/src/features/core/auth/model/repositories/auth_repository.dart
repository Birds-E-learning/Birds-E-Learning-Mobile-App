import 'package:birds_learning_network/src/features/core/auth/model/request_model/login_model.dart';
import 'package:birds_learning_network/src/features/core/auth/model/request_model/otp_model.dart';
import 'package:birds_learning_network/src/features/core/auth/model/request_model/sign_up_model.dart';
import 'package:birds_learning_network/src/features/core/auth/model/response_model/login_response.dart';
import 'package:birds_learning_network/src/features/core/auth/model/response_model/otp_response.dart';
import 'package:birds_learning_network/src/features/core/auth/model/response_model/sign_up_response.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_header.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_service.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_url.dart';

class AuthRepository extends NetworkService with BaseHeaders, BaseUrl {
  Future<SignUpResponse> getSignUpResponse(SignUpModel body) async {
    dynamic response = await postRequest(signUp, header, body.toJson());
    SignUpResponse responseData = SignUpResponse.fromJson(response);
    return responseData;
  }

  Future<LoginResponse> getLoginResponse(LoginModel body) async {
    dynamic response = await postRequest(login, header, body.toJson());
    LoginResponse responseData = LoginResponse.fromJson(response);
    return responseData;
  }

  Future<OtpResponse> getOtpResponse(OtpModel body) async {
    dynamic response = await postRequest(verifyOtp, header, body.toJson());
    OtpResponse responseData = OtpResponse.fromJson(response);
    return responseData;
  }

  Future<OtpResponse> getResendOtpResponse(String email) async {
    dynamic response = await getRequest("$resendOtp$email", header);
    OtpResponse responseData = OtpResponse.fromJson(response);
    return responseData;
  }
}
