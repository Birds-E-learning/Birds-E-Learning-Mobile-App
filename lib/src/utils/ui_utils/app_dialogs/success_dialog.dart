import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/profile_styles/profile_styles.dart';
import 'package:flutter/material.dart';

void successDialog(
  context,
  String headerText,
  String labelText,
  String buttonText,
  VoidCallback onPressed,
) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
          title: Text(headerText,
              style:
                  ProfileStyles.logoutHeaderStyle.copyWith(color: success1000)),
          content: Text(
            labelText,
            style: ProfileStyles.logoutTextStyle,
          ),
          actions: [
            SizedBox(
              width: double.infinity,
              child: TextButton(
                  onPressed: onPressed,
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    backgroundColor: deepGrey,
                    elevation: 3,
                    shadowColor: Colors.grey[100],
                  ),
                  child: Text(
                    buttonText,
                    style: ProfileStyles.logoutButtonStyle
                        .copyWith(color: nextColor, fontSize: 14),
                  )),
            ),
          ]);
    },
  );
}
