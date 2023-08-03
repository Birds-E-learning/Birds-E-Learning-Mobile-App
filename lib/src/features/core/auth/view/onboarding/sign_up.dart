import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/core/auth/model/request_model/auth_model.dart';
import 'package:birds_learning_network/src/features/core/auth/model/request_model/login_model.dart';
import 'package:birds_learning_network/src/features/core/auth/model/request_model/sign_up_model.dart';
import 'package:birds_learning_network/src/features/core/auth/view/auth_screen.dart';
import 'package:birds_learning_network/src/features/core/auth/view/login/sign_in.dart';
import 'package:birds_learning_network/src/features/core/auth/view_model/login_provider/login_provider.dart';
import 'package:birds_learning_network/src/features/core/auth/view_model/oauth_provider.dart';
import 'package:birds_learning_network/src/features/core/auth/view_model/sign_up_provider/sign_up.dart';
import 'package:birds_learning_network/src/global_model/services/storage/shared_preferences/device_info.dart';
import 'package:birds_learning_network/src/global_model/services/storage/shared_preferences/user_details.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/phone_drop_down.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/social_cards.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/text_field.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/core_texts/auth_texts.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_black.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/check_box.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/loading_indicator.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/option_row.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/response_snack.dart';
import 'package:birds_learning_network/src/utils/mixins/core_mixins/auth_mixins/auth_mixins.dart';
import 'package:birds_learning_network/src/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  String? deviceId_;
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
  void initState() {
    setData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    OAuthProvider auth = context.read<OAuthProvider>();
    return Scaffold(
      body: SafeArea(
        child: Consumer<SignUpProvider>(
          builder: (_, register, __) => AuthenticationWidget(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.02,
                    horizontal: size.width * 0.04),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: size.height * 0.03, bottom: 20),
                        child: signsUp(),
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
                        obscureText: !register.showPassword,
                        hintText: AuthTexts.passwordHont,
                        validator: (value) => passwordValidator(value),
                        suffixIcon: passwordVisibility(
                            () => register.onIconClick(),
                            register.showPassword),
                      ),
                      const SizedBox(height: 15),
                      CustomTextField(
                        prefix: PhoneDropDown(
                          onSelect: (value) {
                            setState(() {
                              phoneCode = value.phoneCode.toString();
                            });
                          },
                          data: phoneCode == null ? "+000" : "+$phoneCode",
                        ),
                        controller: phone,
                        labelText: AuthTexts.number,
                        hintText: AuthTexts.phoneHint,
                        keyboardType: TextInputType.number,
                        validator: (value) => numberValidator(value),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          checkBox(register.isChecked,
                              (value) => register.onChecked(value)),
                          const SizedBox(width: 10),
                          Expanded(child: termsText(context)),
                        ],
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: double.infinity,
                        child: BlackButtonWidget(
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              if (register.isClicked) {
                                register.onClick();
                                return;
                              }
                              if (register.isChecked == false) {
                                showSnack(
                                    context, "02", "Accept terms of service");
                                return;
                              }
                              if (_formKey.currentState!.validate()) {
                                register.onClick();
                                SignUpModel data = SignUpModel(
                                    username: email.text.trim(),
                                    emailAddress: email.text.trim(),
                                    password: password.text.trim(),
                                    deviceId: deviceId_ ?? "",
                                    firstName: firstName.text.trim(),
                                    lastName: lastName.text.trim(),
                                    channel: "MOBILE",
                                    userRoles: [],
                                    mobileNumber:
                                        "$phoneCode${phone.text.trim()}");
                                LoginModel loginData = LoginModel(
                                    email: email.text.trim(),
                                    password: password.text.trim(),
                                    deviceId: deviceId_);
                                Provider.of<LoginProvider>(context,
                                        listen: false)
                                    .getLoginData(loginData);
                                if (!mounted) return;
                                await register.userSignUp(context, data);
                              }
                            },
                            child: register.isClicked
                                ? loadingIdicator()
                                : nextButtonText()),
                      ),
                      const SizedBox(height: 20),
                      optionWidget(size, AuthTexts.signUpWith),
                      const SizedBox(height: 20),
                      GoogleCard(
                          text: AuthTexts.googleTextUp,
                          onTap: () async {
                            auth.onGoogleClicked();
                            AuthModel body = AuthModel(
                                authServiceProvider: "GOOGLE",
                                deviceId: deviceId_ ?? "");
                            if (!mounted) return;
                            await auth.oAuthCall(body, "SIGNUP", context);
                          }),
                      const SizedBox(height: 15),
                      accountCheck(
                        AuthTexts.hasAccount1,
                        AuthTexts.login,
                        () async {
                          bool isLoggedIn =
                              await UserPreferences.getLoginStatus();
                          if (!mounted) return;
                          RoutingService.pushRouting(
                              context,
                              isLoggedIn
                                  ? const LoginScreen(firstTime: false)
                                  : const LoginScreen());
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setData() async {
    deviceId_ = await DevicePreference.getDeviceId();
    setState(() {});
  }
}

// OAuthWidget(
//   onFacebookTap: () async {
//     if (auth.facebookClicked) {
//       auth.onFacebookClick();
//       return;
//     }
//     auth.onFacebookClick();
//     auth.facebookAuth(deviceId_ ?? "", context);
//   },
//   onGoogleTap: () async {
// auth.onGoogleClicked();
// AuthModel body = AuthModel(
//     authServiceProvider: "GOOGLE",
//     deviceId: deviceId_ ?? "");
// if (!mounted) return;
// await auth.oAuthCall(body, "SIGNUP", context);
//   },
//   onAppleTap: () async {
//     // auth.onAppleClicked();
//     // AuthModel body = AuthModel(
//     //     authServiceProvider: "APPLE",
//     //     deviceId: deviceId_ ?? "");
//     // await auth.oAuthCall(body,  "SIGNUP", context);
//   },
// ),

// Row(
//   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   children: [
//     SizedBox(
//       height: 51,
//       width: 95,
//       child: PhoneDropDown(
//         onSelect: (value) {
//           setState(() {
//             phoneCode = value.phoneCode.toString();
//           });
//         },
//         data: phoneCode == null ? "+000" : "+$phoneCode",
//       ),
//     ),
//     const SizedBox(width: 20),
//     Expanded(
//         child:
// CustomTextField(
//       prefix: PhoneDropDown(
//         onSelect: (value) {
//           setState(() {
//             phoneCode = value.phoneCode.toString();
//           });
//         },
//         data: phoneCode == null ? "+000" : "+$phoneCode",
//       ),
//       controller: phone,
//       labelText: AuthTexts.number,
//       hintText: AuthTexts.phoneHint,
//       keyboardType: TextInputType.number,
//       validator: (value) => numberValidator(value),
//     ))
//   ],
// ),
