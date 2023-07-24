import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/core/auth/model/repositories/auth_repository.dart';
import 'package:birds_learning_network/src/features/core/auth/model/request_model/sign_up_model.dart';
import 'package:birds_learning_network/src/features/core/auth/model/response_model/sign_up_response.dart';
import 'package:birds_learning_network/src/features/core/auth/view/enter_otp.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/response_snack.dart';
import 'package:flutter/material.dart';

class SignUpProvider extends ChangeNotifier {
  bool _isClicked = false;
  bool _showPassword = false;
  bool _isChecked = false;

  bool get isClicked => _isClicked;

  bool get showPassword => _showPassword;

  bool get isChecked => _isChecked;

  void onClick() {
    _isClicked = !_isClicked;
    notifyListeners();
  }

  void onIconClick() {
    _showPassword = !_showPassword;
    notifyListeners();
  }

  void onChecked(value) {
    _isChecked = value;
    notifyListeners();
  }

  Future userSignUp(context, SignUpModel data) async {
    try {
      SignUpResponse response =
          await AuthRepository().getSignUpResponse(data, context);
      if (response.responseCode == "00") {
        onClick();
        RoutingService.pushReplacementRouting(
            context,
            EnterOTPScreen(
              email: data.emailAddress!,
              isRegister: true,
            ));
        return response;
      } else {
        onClick();
        showSnack(context, response.responseCode!, response.responseMessage!);
      }
    } catch (e) {
      onClick();
      showSnack(context, "02", "Access Denied");
    }
  }
}
