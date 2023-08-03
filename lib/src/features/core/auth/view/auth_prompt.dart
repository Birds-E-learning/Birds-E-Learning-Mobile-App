import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/core/auth/view/login/sign_in.dart';
import 'package:birds_learning_network/src/features/core/auth/view/onboarding/sign_up.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/text_style.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/core_texts/auth_texts.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_black.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_white.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthPromptScreen extends StatelessWidget {
  const AuthPromptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.only(
              left: size.width* 0.04, right: size.width * 0.04,
              top: size.height * 0.25),
          child: LayoutBuilder(
            builder: (_, constraints) => ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    SvgPicture.asset(
                      ImagePath.authPrompt,
                    ),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      SizedBox(
                      width: double.infinity,
                      child: BlackButtonWidget(
                          onPressed: (){
                            RoutingService.pushAndRemoveAllRoute(context, const LoginScreen());
                          }, child: Text(
                        AuthTexts.login,
                        style: TextStyles.buttonStyle.copyWith(color: nextColor),
                          )),
                        ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: WhiteButtonWidget(
                            onPressed: (){
                              RoutingService.pushAndRemoveAllRoute(context, const SignUpScreen());
                            }, child: Text(
                          "Create an account",
                          style: TextStyles.buttonStyle.copyWith(color: skipColor),
                          )),
                        )
                      ]
                    ),
                    const SizedBox(height: 50,)
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
