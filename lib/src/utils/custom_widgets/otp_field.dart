import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/auth_styles/auth_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpField extends StatelessWidget with AuthStyles {
  const OtpField({super.key, required this.onSubmit});
  final ValueChanged<String> onSubmit;

  @override
  Widget build(BuildContext context) {
    return OtpTextField(
      fieldWidth: 60,
      showFieldAsBox: false,
      numberOfFields: 4,
      clearText: true,
      borderWidth: 4,
      borderColor: deepBlack,
      focusedBorderColor: deepGrey,
      textStyle: AuthStyles.labelStyle,
      // onCodeChanged: (value) {
      //   print("got you bro");
      // },
      onSubmit: onSubmit,
    );
  }
}
