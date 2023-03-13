import 'package:birds_learning_network/src/features/modules/profile/view_model/profile_provider.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/profile_styles/profile_styles.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/module_texts/profile_texts.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void logoutDialog(context, VoidCallback onPressed) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
          title: const Text(ProfileTexts.logoutHeader,
              style: ProfileStyles.logoutHeaderStyle),
          content: const Text(ProfileTexts.logoutText,
              style: ProfileStyles.logoutTextStyle),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    ProfileTexts.cancelText,
                    style: ProfileStyles.logoutButtonStyle,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: TextButton(
                  onPressed: onPressed,
                  child: context.watch<ProfileProvider>().isClicked
                      ? loadingIdicator()
                      : const Text(
                          ProfileTexts.confirmButton,
                          style: ProfileStyles.logoutButtonStyle,
                        )),
            ),
          ]);
    },
  );
}
