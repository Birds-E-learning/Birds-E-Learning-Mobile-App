import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/courses_styles/ny_courses_style.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/module_texts/courses_texts.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

mixin CourseTextWidgets on Object implements CoursesText, CourseStyles {
  Text appBarText(String text) {
    return Text(
      text,
      style: CourseStyles.appBarStyle,
    );
  }

  RichText noCourseText(VoidCallback onTap) {
    return RichText(
        text: TextSpan(
            text: CoursesText.journey,
            style: CourseStyles.noCourseLabelStyle,
            children: [
          TextSpan(
            text: CoursesText.browse,
            style: CourseStyles.noCourseLabelStyle.copyWith(color: skipColor),
            recognizer: TapGestureRecognizer()..onTap = onTap,
          )
        ]));
  }
}
