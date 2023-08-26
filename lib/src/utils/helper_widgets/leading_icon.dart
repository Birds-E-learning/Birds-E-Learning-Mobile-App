import 'dart:io';

import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';

IconButton leadingIcon(context, {VoidCallback? onTap}) {
  return IconButton(
      onPressed: onTap ?? () => RoutingService.popRouting(context),
      icon: Icon(
        Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
        color: deepBlack,
      ));
}
