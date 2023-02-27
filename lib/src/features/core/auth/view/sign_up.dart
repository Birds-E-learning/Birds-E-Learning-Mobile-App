import 'package:birds_learning_network/src/utils/custom_widgets/phone_drop_down.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/social_cards.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/text_field.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/core_texts/auth_texts.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_black.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/check_box.dart';
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
  String? phoneCode;
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
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: size.height * 0.02, horizontal: size.width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: size.height * 0.03, bottom: 20),
                  child: signUp(),
                ),
                CustomTextField(
                  controller: firstName,
                  labelText: AuthTexts.firstName,
                  validator: (value) => nameValidator(value, "First"),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: lastName,
                  labelText: AuthTexts.lastName,
                  validator: (value) => nameValidator(value, "Last"),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  labelText: AuthTexts.email,
                  validator: (value) => emailValidator(value),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: password,
                  keyboardType: TextInputType.streetAddress,
                  labelText: AuthTexts.password,
                  validator: (value) => passwordValidator(value),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 3,
                        child: PhoneDropDown(
                          onSelect: (value) {
                            setState(() {
                              phoneCode = value.phoneCode.toString();
                            });
                          },
                          data: phoneCode == null ? "" : "+$phoneCode",
                        )),
                    const SizedBox(width: 10),
                    Expanded(
                        flex: 6,
                        child: CustomTextField(
                          controller: phone,
                          labelText: AuthTexts.number,
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
                      onPressed: () {}, child: nextButtonText()),
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    lineStretch(size),
                    optionText(AuthTexts.signUpWith),
                    lineStretch(size)
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SocialCard(onTap: () {}, image: ImagePath.facebook),
                    SocialCard(onTap: () {}, image: ImagePath.google),
                    SocialCard(onTap: () {}, image: ImagePath.apple),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
