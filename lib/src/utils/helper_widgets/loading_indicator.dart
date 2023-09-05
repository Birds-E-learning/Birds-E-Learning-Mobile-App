import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';

CircularProgressIndicator loadingIdicator({double stroke = 4}) {
  return  CircularProgressIndicator(
    strokeWidth: stroke,
    color: skipColor,
  );
}
