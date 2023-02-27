import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/auth_styles/auth_style.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/text_style.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/core_texts/auth_texts.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

mixin AuthTextWidgets on Object implements AuthStyles, AuthTexts {
  Text signUp() {
    return const Text(
      AuthTexts.signUp,
      style: AuthStyles.signUpStyle,
    );
  }

  Text optionText(String text) {
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

  RichText termsText() {
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
              ..onTap = () {
                print("heeyy");
              }),
        const TextSpan(
          text: AuthTexts.terms3,
          style: AuthStyles.termsStyle,
        ),
        TextSpan(
          text: AuthTexts.terms4,
          style: AuthStyles.termsStyle.copyWith(color: skipColor),
          recognizer: TapGestureRecognizer()..onTap = () {},
        ),
      ],
    ));
  }

  RichText accountCheck(String text1, String text2, VoidCallback onTap) {
    return RichText(
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
    );
  }
}
