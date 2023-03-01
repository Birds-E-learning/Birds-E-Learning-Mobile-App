import 'package:birds_learning_network/src/features/core/auth/view/auth_screen.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/text_field.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/core_texts/auth_texts.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_black.dart';
import 'package:birds_learning_network/src/utils/mixins/core_mixins/auth_mixins/auth_mixins.dart';
import 'package:birds_learning_network/src/utils/validators/validators.dart';
import 'package:flutter/material.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword>
    with AuthTexts, AuthTextWidgets, InputValidators {
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool showPassword = false;
  bool showConfirmPassword = false;

  @override
  void dispose() {
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: AuthenticationWidget(
            child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04, vertical: size.height * 0.03),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(top: size.height * 0.04, bottom: 100),
                    child: resetPassword(),
                  ),
                  CustomTextField(
                    controller: password,
                    keyboardType: TextInputType.streetAddress,
                    labelText: AuthTexts.newPassword,
                    obscureText: showPassword,
                    hintText: AuthTexts.passwordHont,
                    validator: (value) => passwordValidator(value),
                    suffixIcon: passwordVisibility(() {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    }, showPassword),
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: confirmPassword,
                    keyboardType: TextInputType.streetAddress,
                    labelText: AuthTexts.confirmPassword,
                    obscureText: showConfirmPassword,
                    hintText: AuthTexts.passwordHont,
                    validator: (value) => passwordValidator(value),
                    suffixIcon: passwordVisibility(() {
                      setState(() {
                        showConfirmPassword = !showConfirmPassword;
                      });
                    }, showConfirmPassword),
                  ),
                  SizedBox(height: size.height * 0.3),
                  SizedBox(
                    width: double.infinity,
                    child: BlackButtonWidget(
                      child: AuthTextWidgets.updateButtonText(),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
