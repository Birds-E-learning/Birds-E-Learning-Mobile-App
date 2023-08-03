import 'package:birds_learning_network/src/features/core/auth/view/auth_screen.dart';
import 'package:birds_learning_network/src/features/core/auth/view_model/otp_provider.dart';
import 'package:birds_learning_network/src/features/core/auth/view_model/password_reset/reset_password_provider.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/text_field.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/core_texts/auth_texts.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_black.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/loading_indicator.dart';
import 'package:birds_learning_network/src/utils/mixins/core_mixins/auth_mixins/auth_mixins.dart';
import 'package:birds_learning_network/src/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with AuthTextWidgets, AuthTexts, InputValidators {
  TextEditingController email = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Consumer<ResetPasswordProvider>(
          builder: (_, forget, __) => AuthenticationWidget(
              child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.02, horizontal: size.width * 0.04),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: size.height * 0.03, bottom: 20),
                      child: forgotPassword(),
                    ),
                    forgotText(),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller: email,
                      hintText: AuthTexts.emailHint,
                      keyboardType: TextInputType.emailAddress,
                      labelText: AuthTexts.email,
                      validator: (value) => emailValidator(value),
                    ),
                    const SizedBox(height: 50),
                    SizedBox(
                      width: double.infinity,
                      child: BlackButtonWidget(
                        child: forget.getOtpClicked
                            ? loadingIdicator()
                            : AuthTextWidgets.otpButtonText(),
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          if (_formKey.currentState!.validate()) {
                            forget.onGetOtpClick();
                            await forget.getOtpCall(context, email.text.trim());
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    accountCheck(
                      AuthTexts.noOtp,
                      AuthTexts.resend,
                      () {
                        if (_formKey.currentState!.validate()) {
                          context
                              .read<OtpProvider>()
                              .resendOtp(context, email.text.trim(), "Reset");
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          )),
        ),
      ),
    );
  }
}
