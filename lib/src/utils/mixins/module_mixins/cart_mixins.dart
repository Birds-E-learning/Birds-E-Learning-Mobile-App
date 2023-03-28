import 'package:auto_size_text/auto_size_text.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/cart_styles/cart_styles.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/module_texts/cart_texts.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

mixin CartWidgets on Object implements CartStyles, CartTexts {
  Text appBarText() {
    return const Text(
      CartTexts.myCart,
      style: CartStyles.appBarStyle,
    );
  }

  Text wishlistText() {
    return const Text(
      CartTexts.wishlist,
      style: CartStyles.wishStyle,
    );
  }

  RichText emptyCartTexts(VoidCallback onPressed) {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: CartTexts.richText1,
            style: CartStyles.richStyle1,
            children: [
              TextSpan(
                  text: CartTexts.richText2,
                  style: CartStyles.richStyle2,
                  recognizer: TapGestureRecognizer()..onTap = onPressed)
            ]));
  }

  SizedBox courseTitleText(String title) {
    return SizedBox(
      child: AutoSizeText(
        title,
        maxLines: 2,
        style: CartStyles.courseTitleStyle,
      ),
    );
  }

  Text ownerNameText(String owner) {
    return Text(
      owner,
      style: CartStyles.ownerStyle,
    );
  }

  Text ratingText(String rating) {
    return Text(
      "($rating)",
      style: CartStyles.ratingStyle,
    );
  }

  InkWell addRemoveCart(
      String task, Color color, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 17, color: color),
          const SizedBox(width: 10),
          Text(
            task,
            style: CartStyles.buyStyle.copyWith(color: color),
          )
        ],
      ),
    );
  }

  Row amountText(String amount, String oldAmount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "\$ $amount",
          style: CartStyles.amountStyle,
        ),
        const SizedBox(width: 10),
        Text(
          "\$ $oldAmount",
          style: CartStyles.oldAmountStyle,
        )
      ],
    );
  }

  Text buyText() {
    return const Text(
      "Buy Now",
      style: CartStyles.buyStyle,
    );
  }

  Text removeText() {
    return const Text(
      "Remove",
      style: CartStyles.removeStyle,
    );
  }
}
