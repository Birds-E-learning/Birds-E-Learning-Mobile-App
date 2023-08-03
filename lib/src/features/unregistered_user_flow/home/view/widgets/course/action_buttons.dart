import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/core/auth/view/login/sign_in.dart';
import 'package:birds_learning_network/src/features/core/auth/view/onboarding/sign_up.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_black.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_white.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/content_mixins.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/home_mixins.dart';
import 'package:flutter/material.dart';

class CourseActionButtons extends StatelessWidget
    with HomeWidgets, ContentWidget {
  const CourseActionButtons({super.key, required this.course});
  final Courses course;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          height: 60,
          child: BlackButtonWidget(
              onPressed: ()=> RoutingService.pushAndRemoveAllRoute(context, const LoginScreen()),
              child: buttonText(
                  "Login",
                  nextColor)),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          height: 60,
          child: WhiteButtonWidget(
              onPressed: () => RoutingService.pushAndRemoveAllRoute(context, const SignUpScreen()),
              child: buttonText(
                      "Sign Up",
                      skipColor)),
        )
      ],
    );
  }
}
