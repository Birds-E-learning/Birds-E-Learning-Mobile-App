import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/home_styles/home_styles.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/module_texts/home_texts.dart';
import 'package:flutter/material.dart';

mixin FacilitatorMixin on Object implements HomeText, HomeStyles {
  Container profilePicture(String image) {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
        color: backgroundBlurColor,
        shape: BoxShape.circle,
        border: Border.all(width: 1, color: success800),
        image: DecorationImage(
            fit: BoxFit.fill,
            image: image != ""
                ? NetworkImage(image)
                : const AssetImage(ImagePath.facilitator) as ImageProvider),
      ),
    );
  }
}
