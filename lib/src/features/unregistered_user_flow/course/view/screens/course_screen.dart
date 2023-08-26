import 'package:birds_learning_network/src/features/core/auth/view/auth_prompt.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/custom_bacground.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/auth_styles/auth_style.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/module_texts/courses_texts.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/leading_icon.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/courses_mixins.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UnregisteredCourseScreen extends StatelessWidget with CourseTextWidgets, CoursesText{
  const UnregisteredCourseScreen({super.key, this.isFullScreen = false});
  final bool isFullScreen;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BackgroundWidget(
      appBar: SliverAppBar(
        title: appBarText(CoursesText.myCourses),
        pinned: true,
        floating: true,
        leading: isFullScreen ? leadingIcon(context) : null,
        elevation: 0,
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
          child: Column(
          children: [
            SizedBox(height: size.height * 0.22),
            SvgPicture.asset(ImagePath.noCourse),
            const SizedBox(height: 30),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
              children: [
                TextSpan(
                  text: "Start your journey,",
                  style: AuthStyles.termsStyle.copyWith(fontSize: 16),
                  ),
                TextSpan(
                  text: "Sign up now ",
                  style: AuthStyles.termsStyle.copyWith(fontSize: 16, color: skipColor),
                  recognizer: TapGestureRecognizer()
                      ..onTap = () => Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context)=> const AuthPromptScreen()),
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
