import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/profile_styles/profile_styles.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/module_texts/profile_texts.dart';
import 'package:birds_learning_network/src/utils/validators/hash_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

mixin ProfileWidgets on Object implements ProfileStyles, ProfileTexts {
  Text appBarText(String text) {
    return Text(
      text,
      style: ProfileStyles.appBarStyle,
    );
  }

  AutoSizeText userNameText(String name) {
    return AutoSizeText(
      name,
      maxLines: 1,
      minFontSize: 10,
      style: ProfileStyles.nameStyle,
    );
  }

  AutoSizeText emailText(String mail) {
    return AutoSizeText(
      mail,
      maxLines: 1,
      minFontSize: 10,
      style: ProfileStyles.mailStyle,
    );
  }

  Text buttonText(String text) {
    return Text(
      text,
      style: ProfileStyles.buttonStyle,
    );
  }

  Text cancelButton(String text) {
    return Text(
      text,
      style: ProfileStyles.buttonStyle.copyWith(color: skipColor),
    );
  }

  InkWell editProfileText(VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: const Text(
        ProfileTexts.editProfile,
        style: ProfileStyles.editStyle,
      ),
    );
  }

  Container profilePicture(String image, XFile? imageReceived) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: white,
        shape: BoxShape.circle,
        border: Border.all(width: 1, color: black),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: image != ""
              ? NetworkImage(image)
              : imageReceived != null
                  ? FileImage(File(imageReceived.path)) as ImageProvider
                  : const AssetImage(ImagePath.profilePics),
        ),
      ),
      // backgroundImage: image != ""
      //     ? NetworkImage(image)
      //     : imageReceived != null
      //         ? FileImage(File(imageReceived.path)) as ImageProvider
      //         : const AssetImage(ImagePath.profilePics),
    );
  }

  Container cameraAvatar() {
    return Container(
      height: 40,
      width: 40,
      decoration:  BoxDecoration(shape: BoxShape.circle,
          border: Border.all(color: black, width: 0.5),
          color: white),
      child: ClipOval(
        child: SvgPicture.asset(
          ImagePath.camera,
          fit: BoxFit.scaleDown,
        ),
      ),
    );
  }

  Text pageText(String title) {
    return Text(
      title,
      style: ProfileStyles.pagesStyle,
    );
  }

  InkWell logoutRow(VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(ImagePath.logout),
          const SizedBox(width: 15),
          const Text(
            ProfileTexts.logout,
            style: ProfileStyles.logoutStyle,
          )
        ],
      ),
    );
  }

  Center versionText() {
    return const Center(
      child: Text(
        ProfileTexts.version,
        style: ProfileStyles.versionStyle,
        textAlign: TextAlign.center,
      ),
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

  Text editHeaderText() {
    return const Text(
      ProfileTexts.infoText,
      style: ProfileStyles.editTitleStyle,
    );
  }

  Text cardLabelText(String text) {
    return Text(
      text,
      style: ProfileStyles.cardStyle,
    );
  }

  Text cardTitleStyle(String text) {
    return Text(
      text,
      style: ProfileStyles.fieldTitleStyle,
    );
  }

  Align contactLabelStyle() {
    return const Align(
      alignment: Alignment.center,
      child: Text(
        ProfileTexts.contactLabel,
        textAlign: TextAlign.center,
        style: ProfileStyles.contactTextStyle,
      ),
    );
  }

  AutoSizeText cardNumber(String cardNo) {
    return AutoSizeText(
      hashCardNo(cardNo),
      style: ProfileStyles.cardNoStyle,
    );
  }

  AutoSizeText cardDetailsText(String detail) {
    return AutoSizeText(
      detail,
      style: ProfileStyles.cardDetailsStyle,
    );
  }
}
