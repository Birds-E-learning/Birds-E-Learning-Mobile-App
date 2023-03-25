import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';

class PaymentStyles {
  static const TextStyle titleStyle = TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      fontFamily: "Inter",
      color: success1000);

  static const TextStyle fieldTitleStyle = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      fontFamily: "Inter",
      color: success1000);

  static const TextStyle fieldHintStyle = TextStyle(
      color: success1000,
      fontWeight: FontWeight.w400,
      fontSize: 16,
      fontFamily: "Inter");

  static const TextStyle buttonStyle = TextStyle(
      fontFamily: "Inter",
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: nextColor);

  static const TextStyle labelStyle = TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 12,
      color: greys300,
      fontFamily: "Inter");

  static const TextStyle cancelButtonStyle = TextStyle(
      fontSize: 16,
      fontFamily: "Inter",
      fontWeight: FontWeight.w500,
      color: skipColor);
}
