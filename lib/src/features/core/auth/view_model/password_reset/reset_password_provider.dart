import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/core/auth/model/repositories/auth_repository.dart';
import 'package:birds_learning_network/src/features/core/auth/model/request_model/reset_model.dart';
import 'package:birds_learning_network/src/features/core/auth/model/response_model/otp_response.dart';
import 'package:birds_learning_network/src/features/core/auth/model/response_model/reset_response.dart';
import 'package:birds_learning_network/src/features/core/auth/view/onboarding/enter_otp.dart';
import 'package:birds_learning_network/src/features/core/auth/view/login/sign_in.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/response_snack.dart';
import 'package:birds_learning_network/src/utils/ui_utils/app_dialogs/success_dialog.dart';
import 'package:flutter/material.dart';

class ResetPasswordProvider extends ChangeNotifier {
  bool _getOtpClicked = false;
  bool _resetClicked = false;
  bool _passwordIconClicked = false;
  bool _confirmIconClicked = false;

  bool get passwordIconClicked => _passwordIconClicked;
  bool get confirmIconClicked => _confirmIconClicked;
  bool get getOtpClicked => _getOtpClicked;
  bool get resetClicked => _resetClicked;

  void onGetOtpClick() {
    _getOtpClicked = !_getOtpClicked;
    notifyListeners();
  }

  void onPasswordIconClick() {
    _passwordIconClicked = !_passwordIconClicked;
    notifyListeners();
  }

  void onConfirmIconClick() {
    _confirmIconClicked = !_confirmIconClicked;
    notifyListeners();
  }

  void onResetClick() {
    _resetClicked = !_resetClicked;
    notifyListeners();
  }

  Future getOtpCall(context, String email) async {
    try {
      OtpResponse response =
          await AuthRepository().getResendOtpResponse("reset", email, context);
      onGetOtpClick();
      if (response.responseCode == "00") {
        RoutingService.pushReplacementRouting(
            context, EnterOTPScreen(email: email));
      } else {
        showSnack(context, response.responseCode!, response.responseMessage!);
      }
    } catch (e) {
      onGetOtpClick();
      showSnack(context, "02", "Network TimedOut");
    }
  }

  Future resetPasswordCall(context, ResetModel data) async {
    try {
      ResetResponse response =
          await AuthRepository().getResetPasswordResponse(data, context);
      onResetClick();
      if (response.responseCode == "00") {
        successDialog(context, "Reset Successful!",
            "Password successfully changed!", "OK", () {
          RoutingService.pushAndRemoveAllRoute(
              context, const LoginScreen(firstTime: true));
        });
      } else {
        showSnack(context, response.responseCode!, response.responseMessage!);
      }
    } catch (e) {
      onResetClick();
      showSnack(context, "02", "Network TimedOut");
    }
  }
}
