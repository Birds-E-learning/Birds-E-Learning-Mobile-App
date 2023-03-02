import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/snack_bar.dart';
import 'package:flutter/material.dart';

showSnack(BuildContext context, String responseCode, String message) {
  switch (responseCode) {
    case "00":
      return CustomSnackbar.responseSnackbar(context, black, message);
    case "02":
      return CustomSnackbar.responseSnackbar(context, redAccent, message);
    default:
      return CustomSnackbar.responseSnackbar(context, redAccent, message);
  }
}
