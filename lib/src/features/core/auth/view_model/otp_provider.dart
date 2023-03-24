import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/core/auth/model/repositories/auth_repository.dart';
import 'package:birds_learning_network/src/features/core/auth/model/request_model/otp_model.dart';
import 'package:birds_learning_network/src/features/core/auth/model/response_model/otp_response.dart';
import 'package:birds_learning_network/src/features/core/auth/view/otp_success.dart';
import 'package:birds_learning_network/src/features/core/auth/view/reset_password.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/response_snack.dart';
import 'package:flutter/material.dart';

class OtpProvider extends ChangeNotifier {
  bool _isClicked = false;

  String _otp = "";

  bool get isClicked => _isClicked;

  String get otp => _otp;

  void onClick() {
    _isClicked = !_isClicked;
    notifyListeners();
  }

  void getOtp(value) {
    _otp = value;
    notifyListeners();
  }

  Future verifyOTP(
      context, OtpModel data, bool isRegistered, String email) async {
    try {
      OtpResponse response =
          await AuthRepository().getOtpResponse(isRegistered, data, context);
      if (response.responseCode == "00") {
        onClick();
        isRegistered
            ? RoutingService.pushReplacementRouting(
                context, const OtpSuccessPage())
            : RoutingService.pushReplacementRouting(
                context, ResetPassword(email: email));
        return response;
      } else {
        showSnack(context, response.responseCode!, response.responseMessage!);
        onClick();
      }
    } catch (e) {
      onClick();
      showSnack(context, "02", "Network TimedOut");
    }
  }

  Future resendOtp(context, String email, String mode) async {
    OtpResponse response =
        await AuthRepository().getResendOtpResponse(mode, email, context);
    if (response.responseCode == "00") {
      showSnack(context, response.responseCode!, response.responseMessage!);
    } else {
      showSnack(context, response.responseCode!, response.responseMessage!);
    }
  }
}