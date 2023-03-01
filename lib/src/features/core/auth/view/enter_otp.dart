import 'package:birds_learning_network/src/features/core/auth/view/auth_screen.dart';
import 'package:birds_learning_network/src/features/core/auth/view/otp_success.dart';
import 'package:birds_learning_network/src/features/core/auth/view/reset_password.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/otp_field.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/core_texts/auth_texts.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_black.dart';
import 'package:birds_learning_network/src/utils/mixins/core_mixins/auth_mixins/auth_mixins.dart';
import 'package:flutter/material.dart';

class EnterOTPScreen extends StatelessWidget with AuthTextWidgets, AuthTexts {
  const EnterOTPScreen(
      {super.key, required this.email, this.isRegister = false});
  final String email;
  final bool isRegister;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String otp = "";
    return Scaffold(
      body: SafeArea(
          child: AuthenticationWidget(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04, vertical: size.height * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  ImagePath.otp,
                  height: size.height * 0.4,
                  width: double.infinity,
                ),
                const SizedBox(height: 50),
                AuthTextWidgets.verifyText(),
                const SizedBox(height: 15),
                AuthTextWidgets.verifyEmail(email),
                const SizedBox(height: 20),
                OtpField(
                  onSubmit: (value) {
                    print(value);
                  },
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: BlackButtonWidget(
                      onPressed: () {
                        print(otp);
                        isRegister
                            ? Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const OtpSuccessPage()))
                            : Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const ResetPassword()));
                      },
                      child: AuthTextWidgets.verifyButtonText()),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
