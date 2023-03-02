import 'package:birds_learning_network/src/features/core/auth/model/request_model/otp_model.dart';
import 'package:birds_learning_network/src/features/core/auth/view/auth_screen.dart';
import 'package:birds_learning_network/src/features/core/auth/view_model/otp_provider.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/otp_field.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/core_texts/auth_texts.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_black.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/loading_indicator.dart';
import 'package:birds_learning_network/src/utils/mixins/core_mixins/auth_mixins/auth_mixins.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnterOTPScreen extends StatefulWidget with AuthTextWidgets, AuthTexts {
  const EnterOTPScreen(
      {super.key, required this.email, this.isRegister = false});
  final String email;
  final bool isRegister;

  @override
  State<EnterOTPScreen> createState() => _EnterOTPScreenState();
}

class _EnterOTPScreenState extends State<EnterOTPScreen> with AuthTextWidgets {
  String otp = "";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Consumer<OtpProvider>(
        builder: (_, verify, __) => AuthenticationWidget(
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
                  AuthTextWidgets.verifyEmail(widget.email),
                  const SizedBox(height: 20),
                  OtpField(
                    onSubmit: (value) => verify.getOtp(value),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    child: BlackButtonWidget(
                        onPressed: () {
                          if (verify.isClicked) {
                            verify.onClick();
                            return;
                          }
                          if (verify.otp.isNotEmpty) {
                            verify.onClick();
                            OtpModel data = OtpModel(
                                otp: verify.otp,
                                userEmail: widget.email.toString());
                            verify.verifyOTP(context, data, widget.isRegister);
                          }
                        },
                        child: verify.isClicked
                            ? loadingIdicator()
                            : AuthTextWidgets.verifyButtonText()),
                  ),
                  const SizedBox(height: 15),
                  accountCheck(
                    AuthTexts.noOtp,
                    AuthTexts.resend,
                    () {
                      verify.resendOtp(context, widget.email);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
