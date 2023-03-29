import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/core/auth/model/request_model/auth_model.dart';
import 'package:birds_learning_network/src/features/core/auth/model/request_model/login_model.dart';
import 'package:birds_learning_network/src/features/core/auth/view/auth_screen.dart';
import 'package:birds_learning_network/src/features/core/auth/view/forgot_password.dart';
import 'package:birds_learning_network/src/features/core/auth/view/sign_up.dart';
import 'package:birds_learning_network/src/features/core/auth/view_model/login_provider/login_provider.dart';
import 'package:birds_learning_network/src/features/core/auth/view_model/oauth_provider.dart';
import 'package:birds_learning_network/src/global_model/services/storage/shared_preferences/device_info.dart';
import 'package:birds_learning_network/src/global_model/services/storage/shared_preferences/user_details.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/social_cards.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/text_field.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/core_texts/auth_texts.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_black.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/loading_indicator.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/option_row.dart';
import 'package:birds_learning_network/src/utils/mixins/core_mixins/auth_mixins/auth_mixins.dart';
import 'package:birds_learning_network/src/utils/validators/validators.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    this.firstTime = true,
  });
  final bool firstTime;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with AuthTextWidgets, AuthTexts, InputValidators {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? userFirstName;
  String? deviceId_;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  void initState() {
    setUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    OAuthProvider auth = context.read<OAuthProvider>();
    return Scaffold(
      body: SafeArea(
        child: Consumer<LoginProvider>(
          builder: (_, login, __) => AuthenticationWidget(
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
                            top: size.height * 0.03, bottom: 50),
                        child: widget.firstTime
                            ? firstLogin()
                            : loginHeader(userFirstName ?? ""),
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
                        obscureText: !login.showPassword,
                        labelText: AuthTexts.password,
                        hintText: AuthTexts.passwordHont,
                        validator: (value) => passwordValidator(value),
                        suffixIcon: passwordVisibility(
                            () => login.onIconClicked(), login.showPassword),
                      ),
                      const SizedBox(height: 15),
                      rememberField(
                        login.isChecked,
                        (value) => login.onChecked(
                            value, email.text.trim(), password.text.trim()),
                        () {
                          RoutingService.pushRouting(
                              context, const ForgotPasswordScreen());
                        },
                      ),
                      const SizedBox(height: 50),
                      SizedBox(
                        width: double.infinity,
                        child: BlackButtonWidget(
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            if (login.isClicked) {
                              login.onClick();
                              return;
                            }
                            if (_formKey.currentState!.validate()) {
                              LoginModel data = LoginModel(
                                  email: email.text.trim(),
                                  password: password.text.trim(),
                                  rememberMe: login.isChecked,
                                  deviceId: deviceId_ ?? "");
                              login.onClick();
                              if (!mounted) return;
                              login.userLogin(context, data, false);
                            }
                          },
                          child: login.isClicked
                              ? loadingIdicator()
                              : loginButtonText(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      optionWidget(size, AuthTexts.loginWith),
                      const SizedBox(height: 20),
                      GoogleCard(
                          text: AuthTexts.googleTextIn,
                          onTap: () async {
                            if (auth.googleClicked) {
                              auth.onGoogleClicked();
                              return;
                            }
                            auth.onGoogleClicked();
                            AuthModel body = AuthModel(
                                authServiceProvider: "GOOGLE",
                                deviceId: deviceId_ ?? "");
                            await auth.oAuthCall(body, "LOGIN", context);
                          }),
                      const SizedBox(height: 15),
                      accountCheck(
                        AuthTexts.noAccount,
                        AuthTexts.signUp,
                        () {
                          RoutingService.pushRouting(
                              context, const SignUpScreen());
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

  void setUser() async {
    context.read<LoginProvider>().isCheckedValue();
    email.text = await context.read<LoginProvider>().getUsername();
    if (!mounted) return;
    password.text = await context.read<LoginProvider>().getPassword();
    userFirstName = await UserPreferences.getUserFirstName();
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
                      //     await login.facebookAuthLogin(
                      //         deviceId_ ?? "", context);
                      //   },
                      //   onGoogleTap: () async {
                          // if (auth.googleClicked) {
                          //   auth.onGoogleClicked();
                          //   return;
                          // }
                          // auth.onGoogleClicked();
                          // AuthModel body = AuthModel(
                          //     authServiceProvider: "GOOGLE",
                          //     deviceId: deviceId_ ?? "");
                          // await auth.oAuthCall(body, "LOGIN", context);
                      //   },
                      //   onAppleTap: () async {
                      //     if (auth.appleClicked) {
                      //       auth.onAppleClicked();
                      //       return;
                      //     }
                      //     // auth.onAppleClicked();
                      //     // AuthModel body = AuthModel(
                      //     //     authServiceProvider: "APPLE",
                      //     //     deviceId: deviceId_);
                      //     // await auth.oAuthCall(body,"LOGIN", context);
                      //   },
                      // ),