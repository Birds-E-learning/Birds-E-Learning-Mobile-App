import 'dart:io';

import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/payment_styles.dart/payment_style.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/module_texts/payment_texts.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/check_box.dart';
import 'package:flutter/material.dart';

mixin PaymentWidgets on Object implements PaymentStyles, PaymentTexts {
  Text buttonText() {
    return const Text(
      PaymentTexts.payButton,
      style: PaymentStyles.buttonStyle,
    );
  }

  Text appBarText(String text) {
    return Text(
      text,
      style: PaymentStyles.titleStyle,
    );
  }

  Text cancelButton() {
    return const Text(
      PaymentTexts.cancelButton,
      style: PaymentStyles.cancelButtonStyle,
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

  Text cardLabelText(String text) {
    return Text(
      text,
      style: PaymentStyles.labelStyle,
    );
  }

  Text cardTitleStyle(String text) {
    return Text(
      text,
      style: PaymentStyles.fieldTitleStyle,
    );
  }

  Row saveCard(bool checked, ValueChanged<bool?> onClicked) {
    return Row(
      children: [
        checkBox(checked, onClicked),
        const SizedBox(width: 10),
        const Text(
          PaymentTexts.saveCardText,
          style: PaymentStyles.labelStyle,
        )
      ],
    );
  }

  RichText stripeText() {
    return RichText(
        text: TextSpan(
            text: "Powered By: ",
            style: PaymentStyles.labelStyle.copyWith(fontSize: 14),
            children: const [
          TextSpan(text: "Stripe", style: PaymentStyles.stripeStyle)
        ]));
  }
}
