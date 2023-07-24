import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/home_styles/facilitator_style.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/module_texts/home_texts.dart';
import 'package:flutter/material.dart';

mixin FacilitatorMixin on Object implements HomeText, FacilitatorStyle {
  Container profilePicture(String image) {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        color: backgroundBlurColor,
        shape: BoxShape.circle,
        border: Border.all(width: 1, color: success800),
        image: image == ""
            ? null
            : DecorationImage(fit: BoxFit.fill, image: NetworkImage(image)),
      ),
    );
  }

  Text nameText(String name) {
    return Text(
      name,
      style: FacilitatorStyle.nameStyke,
    );
  }

  Container titleCard(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: success100,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(text, style: FacilitatorStyle.titleStyke),
    );
  }

  Text labelText(String text) {
    return Text(
      text,
      style: FacilitatorStyle.labelStyke,
    );
  }

  Container cardText(String title, String text) {
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: success100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: FacilitatorStyle.cardTextStyke),
          Text(text, style: FacilitatorStyle.cardValueStyke)
        ],
      ),
    );
  }
}
