import 'package:birds_learning_network/src/global_model/repositories/url_launcher.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/auth_styles/auth_style.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/text_style.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/core_texts/auth_texts.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/check_box.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

mixin AuthTextWidgets on Object implements AuthStyles, AuthTexts {
  Text signsUp() {
    return const Text(
      AuthTexts.signUp,
      style: AuthStyles.signUpStyle,
    );
  }

  Text firstLogin() {
    return const Text(
      AuthTexts.firstLogin,
      style: AuthStyles.signInStyle,
    );
  }

  Text loginHeader(String name) {
    return Text(
      "${AuthTexts.loginHeader}$name!",
      style: AuthStyles.signInStyle,
    );
  }

  Text resetPassword() {
    return const Text(
      AuthTexts.reset,
      style: AuthStyles.signInStyle,
    );
  }

  static Text googleText(String text) {
    return Text(
      text,
      style: AuthStyles.labelStyle.copyWith(color: grey500),
    );
  }

  Text forgotPassword() {
    return const Text(
      AuthTexts.forgotPass,
      style: AuthStyles.signInStyle,
    );
  }

  static Text optionText(String text) {
    return Text(
      text,
      style: AuthStyles.optionStyle,
    );
  }

  Text labelText(String text) {
    return Text(
      text,
      style: AuthStyles.labelStyle,
    );
  }

  Text nextButtonText() {
    return Text(
      AuthTexts.next,
      style: TextStyles.buttonStyle.copyWith(color: nextColor),
    );
  }

  static Text buttonText(String text) {
    return Text(
      text,
      style: TextStyles.buttonStyle.copyWith(color: nextColor),
    );
  }

  Text loginButtonText() {
    return Text(
      AuthTexts.login,
      style: TextStyles.buttonStyle.copyWith(color: nextColor),
    );
  }

  static Text otpButtonText() {
    return Text(
      AuthTexts.otp,
      style: TextStyles.buttonStyle.copyWith(color: nextColor),
    );
  }

  static Text verifyButtonText() {
    return Text(
      AuthTexts.verify,
      style: TextStyles.buttonStyle.copyWith(color: nextColor),
    );
  }

  static Text updateButtonText() {
    return Text(
      AuthTexts.update,
      style: TextStyles.buttonStyle.copyWith(color: nextColor),
    );
  }

  Text forgotText() {
    return const Text(
      AuthTexts.forgotText,
      style: AuthStyles.forgotTextStyle,
    );
  }

  static Align verifyText() {
    return const Align(
      alignment: Alignment.center,
      child: Text(
        AuthTexts.verifyOtp,
        style: AuthStyles.verifyStyle,
      ),
    );
  }

  static Align sucessText() {
    return const Align(
      alignment: Alignment.center,
      child: Text(
        AuthTexts.otpSuccess,
        style: AuthStyles.otpSuccessStyle,
        textAlign: TextAlign.center,
      ),
    );
  }

  Row rememberField(
      bool checked, ValueChanged<bool?> onClicked, VoidCallback onPressed) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            checkBox(checked, onClicked),
            const SizedBox(width: 10),
            const Text(
              AuthTexts.remember,
              style: AuthStyles.forgotStyle,
            )
          ],
        ),
        InkWell(
          onTap: onPressed,
          child: Text(
            AuthTexts.forgotPassword,
            style: AuthStyles.forgotStyle.copyWith(color: success800),
          ),
        )
      ],
    );
  }

  RichText termsText(context) {
    return RichText(
        text: TextSpan(
      children: [
        const TextSpan(
          text: AuthTexts.terms1,
          style: AuthStyles.termsStyle,
        ),
        TextSpan(
            text: AuthTexts.terms2,
            style: AuthStyles.termsStyle.copyWith(color: skipColor),
            recognizer: TapGestureRecognizer()
              ..onTap = () => UrlLauncher().urlLauncher(
                  "https://blns.dgtechltd.com/public/page/term-of-service",
                  context)),
        const TextSpan(
          text: AuthTexts.terms3,
          style: AuthStyles.termsStyle,
        ),
        TextSpan(
          text: AuthTexts.terms4,
          style: AuthStyles.termsStyle.copyWith(color: skipColor),
          recognizer: TapGestureRecognizer()
            ..onTap = () => UrlLauncher().urlLauncher(
                "https://blns.dgtechltd.com/page/privacy-policy", context),
        ),
      ],
    ));
  }

  Align accountCheck(String text1, String text2, VoidCallback onTap) {
    return Align(
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
            text: text1,
            style: AuthStyles.richStyle1,
          ),
          TextSpan(
              text: text2,
              style: AuthStyles.richStyle2,
              recognizer: TapGestureRecognizer()..onTap = onTap)
        ]),
      ),
    );
  }

  static Align verifyEmail(String text) {
    return Align(
      alignment: Alignment.center,
      child: Text.rich(
        TextSpan(children: [
          const TextSpan(
            text: AuthTexts.otpText,
            style: AuthStyles.otpTextStyle1,
          ),
          TextSpan(
            text: text,
            style: AuthStyles.richStyle2,
          )
        ]),
        textAlign: TextAlign.center,
      ),
    );
  }
}
