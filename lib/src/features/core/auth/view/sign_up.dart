import 'package:birds_learning_network/src/features/core/auth/view/auth_screen.dart';
import 'package:birds_learning_network/src/features/core/auth/view/enter_otp.dart';
import 'package:birds_learning_network/src/features/core/auth/view/sign_in.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/o_auth.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/phone_drop_down.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/social_cards.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/text_field.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/core_texts/auth_texts.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_black.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/check_box.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/option_row.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/stroke_line.dart';
import 'package:birds_learning_network/src/utils/mixins/core_mixins/auth_mixins/auth_mixins.dart';
import 'package:birds_learning_network/src/utils/validators/validators.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with AuthTextWidgets, AuthTexts, InputValidators {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? phoneCode;
  bool showPassword = false;
  bool checked = false;
  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    password.dispose();
    phone.dispose();
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
                      child: signUp(),
                    ),
                    CustomTextField(
                      controller: firstName,
                      hintText: AuthTexts.firstNameHint,
                      labelText: AuthTexts.firstName,
                      validator: (value) => nameValidator(value, "First"),
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      controller: lastName,
                      hintText: AuthTexts.lastNameHint,
                      labelText: AuthTexts.lastName,
                      validator: (value) => nameValidator(value, "Last"),
                    ),
                    const SizedBox(height: 15),
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
                      labelText: AuthTexts.password,
                      obscureText: showPassword,
                      hintText: AuthTexts.passwordHont,
                      validator: (value) => passwordValidator(value),
                      suffixIcon: passwordVisibility(() {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      }, showPassword),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: PhoneDropDown(
                            onSelect: (value) {
                              setState(() {
                                phoneCode = value.phoneCode.toString();
                              });
                            },
                            data: phoneCode == null ? "+000" : "+$phoneCode",
                          ),
                        )),
                        const SizedBox(width: 25),
                        Expanded(
                            child: CustomTextField(
                          controller: phone,
                          labelText: AuthTexts.number,
                          hintText: AuthTexts.phoneHint,
                          keyboardType: TextInputType.number,
                          validator: (value) => numberValidator(value),
                        ))
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        checkBox(checked, (value) {
                          setState(() {
                            checked = value!;
                          });
                        }),
                        const SizedBox(width: 10),
                        Expanded(child: termsText()),
                      ],
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      child: BlackButtonWidget(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => EnterOTPScreen(
                                          email: email.text,
                                          isRegister: true,
                                        )));
                          },
                          child: nextButtonText()),
                    ),
                    const SizedBox(height: 20),
                    optionWidget(size, AuthTexts.signUpWith),
                    const SizedBox(height: 20),
                    OAuthWidget(
                        onFacebookTap: () {},
                        onGoogleTap: () {},
                        onAppleTap: () {}),
                    const SizedBox(height: 15),
                    accountCheck(
                      AuthTexts.hasAccount1,
                      AuthTexts.login,
                      () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LoginScreen()));
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
