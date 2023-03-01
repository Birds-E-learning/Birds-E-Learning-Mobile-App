import 'package:birds_learning_network/src/utils/helper_widgets/stroke_line.dart';
import 'package:birds_learning_network/src/utils/mixins/core_mixins/auth_mixins/auth_mixins.dart';
import 'package:flutter/material.dart';

Row optionWidget(
  Size size,
  String text,
) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      lineStretch(size),
      AuthTextWidgets.optionText(text),
      lineStretch(size)
    ],
  );
}
