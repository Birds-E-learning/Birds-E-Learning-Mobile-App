import 'package:birds_learning_network/src/features/core/auth/view/sign_up.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/custom_bacground.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/auth_styles/auth_style.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/module_texts/profile_texts.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/leading_icon.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/courses_mixins.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UnregisteredProfileScreen extends StatelessWidget with CourseTextWidgets{
  const UnregisteredProfileScreen({super.key, this.isFullScreen = false});
  final bool isFullScreen;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BackgroundWidget(
      appBar: SliverAppBar(
        title: appBarText(ProfileTexts.profileAppBar),
        pinned: true,
        floating: true,
        leading: isFullScreen ? leadingIcon(context) : null,
        elevation: 0,
        backgroundColor: backgroundBlurColor,
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.15),
              SvgPicture.asset(ImagePath.noProfile),
              const SizedBox(height: 30),
              RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Profile not found, ",
                        style: AuthStyles.termsStyle.copyWith(fontSize: 16),
                      ),
                      TextSpan(
                        text: "Sign up to create one",
                        style: AuthStyles.termsStyle.copyWith(fontSize: 16, color: skipColor),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context)=> const SignUpScreen()),
                                  (route) => false),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
