import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/courses_styles/ny_courses_style.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/home_styles/home_styles.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/module_texts/home_texts.dart';
import 'package:flutter/material.dart';

mixin HomeWidgets on Object implements HomeText, HomeStyles {
  Text greetingText(String name) {
    return Text(
      "${HomeText.hiText}$name 👋",
      style: HomeStyles.greetingStyle,
    );
  }

  Text appBarTex(String name) {
    return Text(
      name,
      style: HomeStyles.greetingStyle,
    );
  }

  Text prefText(String text) {
    return Text(
      text,
      style: HomeStyles.prefStyle,
    );
  }

  Padding categoryRowText(
      String category, VoidCallback onPressed, EdgeInsets padding) {
    return Padding(
        padding: padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              category,
              style: HomeStyles.headerStyle,
            ),
            InkWell(
              onTap: onPressed,
              child: const Text(
                HomeText.seeMore,
                style: HomeStyles.moreStyle,
              ),
            )
          ],
        ));
  }

  Text categoryHeaderText(String category) {
    return Text(
      category,
      style: HomeStyles.headerStyle,
    );
  }

  SizedBox courseTitleText(String text) {
    return SizedBox(
      child: AutoSizeText(
        text,
        maxLines: 2,
        // overflow: TextOverflow.ellipsis,
        style: HomeStyles.courseTitleStyle,
      ),
    );
  }

  IconButton leadingIcon(context) {
    return IconButton(
        onPressed: () => RoutingService.popRouting(context),
        icon: Icon(
          Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
          color: deepBlack,
        ));
  }

  AutoSizeText ownerText(String owner) {
    return AutoSizeText(
      owner,
      maxLines: 1,
      style: HomeStyles.courseOwnertyle,
    );
  }

  Text ratingText(String rating) {
    return Text(
      "($rating)",
      style: HomeStyles.ratingStyle,
    );
  }

  Row amountText(String amount, String oldAmount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          amount,
          style: HomeStyles.amountStyle,
        ),
        const SizedBox(width: 10),
        Text(
          oldAmount,
          style: HomeStyles.canceledAmountStyle,
        )
      ],
    );
  }

  Text labelText(String label) {
    return Text(
      label,
      style: HomeStyles.navLabelStyle,
    );
  }

  RichText searchHeaderText(String category) {
    return RichText(
      text: TextSpan(
          text: HomeText.searchText,
          style: HomeStyles.searchStyle,
          children: [
            TextSpan(
                text: '"$category"',
                style: HomeStyles.searchStyle.copyWith(
                  color: skipColor,
                )),
          ]),
    );
  }

  Text authorNameText(String author) {
    return Text(
      author,
      style: HomeStyles.authorNameStyle,
    );
  }

  Text noCourseText() {
    return const Text(
      "No course found!",
      textAlign: TextAlign.center,
      style: CourseStyles.noCourseLabelStyle,
    );
  }

  Text authorHeaderText(String name) {
    return Text(
      name,
      style: HomeStyles.authorHeaderStyle,
    );
  }

  Text authorLabelText(String label) {
    return Text(
      label,
      style: HomeStyles.authorHeaderStyle,
    );
  }

  Row detailRowText(String detail, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: skipColor, size: 10),
        const SizedBox(width: 5),
        Text(
          detail,
          style: HomeStyles.authorTextStyle,
        )
      ],
    );
  }

  Text backButton(String text) {
    return Text(
      text,
      style: HomeStyles.navLabelStyle.copyWith(color: skipColor),
    );
  }
}