import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';

SizedBox lineStretch(Size size) {
  return SizedBox(
    height: 1,
    width: size.width * 0.25,
    child: Container(
      color: lineColor,
    ),
  );
}
