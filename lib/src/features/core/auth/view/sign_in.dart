import 'package:birds_learning_network/src/features/core/auth/view/auth_screen.dart';
import 'package:birds_learning_network/src/features/core/auth/view/forgot_password.dart';
import 'package:birds_learning_network/src/features/core/auth/view/sign_up.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/o_auth.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/text_field.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/core_texts/auth_texts.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_black.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/option_row.dart';
import 'package:birds_learning_network/src/utils/mixins/core_mixins/auth_mixins/auth_mixins.dart';
import 'package:birds_learning_network/src/utils/validators/validators.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with AuthTextWidgets, AuthTexts, InputValidators {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool showPassword = false;
  bool checked = false;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
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
                  vertical: size.height * 0.02, horizontal: size.width * 0.04),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: size.height * 0.03, bottom: 20),
                      child: firstLogin(),
                    ),
                    CustomTextField(
                      controller: email,
                      hintText: AuthTexts.emailHint,
                      keyboardType: TextInputType.emailAddress,
                      labelText: AuthTexts.email,
                      validator: (value) => emailValidator(value),
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      controller: password,
                      keyboardType: TextInputType.streetAddress,
                      obscureText: showPassword,
                      labelText: AuthTexts.password,
                      hintText: AuthTexts.passwordHont,
                      validator: (value) => passwordValidator(value),
                      suffixIcon: passwordVisibility(() {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      }, showPassword),
                    ),
                    const SizedBox(height: 15),
                    rememberField(
                      checked,
                      (value) {
                        setState(() {
                          checked = value!;
                        });
                      },
                      () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const ForgotPasswordScreen()));
                      },
                    ),
                    const SizedBox(height: 50),
                    SizedBox(
                      width: double.infinity,
                      child: BlackButtonWidget(
                        onPressed: () {},
                        child: loginButtonText(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    optionWidget(size, AuthTexts.loginWith),
                    const SizedBox(height: 20),
                    OAuthWidget(
                      onFacebookTap: () {},
                      onGoogleTap: () {},
                      onAppleTap: () {},
                    ),
                    const SizedBox(height: 15),
                    accountCheck(
                      AuthTexts.noAccount,
                      AuthTexts.signUp,
                      () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const SignUpScreen()));
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
