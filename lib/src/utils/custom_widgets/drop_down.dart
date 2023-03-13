import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/auth_styles/auth_style.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/profile_styles/profile_styles.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown(
      {super.key,
      required this.value,
      this.items,
      this.onChanged,
      this.hint = ""});
  final dynamic value;
  final List<DropdownMenuItem<dynamic>>? items;
  final ValueChanged<dynamic>? onChanged;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return DropdownButton2(
      icon: SvgPicture.asset(ImagePath.arrowDown),
      underline: DropdownButtonHideUnderline(child: Container()),
      style: ProfileStyles.fieldTitleStyle,
      items: items,
      hint: Text(
        hint,
        style: AuthStyles.labelStyle,
      ),
      value: value,
      onChanged: onChanged,
      buttonWidth: double.infinity,
      buttonHeight: 50,
      buttonPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      itemPadding: const EdgeInsets.only(left: 20),
      // itemHeight: 30,
      dropdownDecoration: BoxDecoration(
          color: backgroundBlurColor, borderRadius: BorderRadius.circular(10)),
    );
  }
}

class DropDownCustom extends StatelessWidget {
  const DropDownCustom(
      {this.hint = "",
      required this.items,
      required this.onChanged,
      this.value,
      super.key});
  final List<String> items;
  final dynamic value;
  final String hint;
  final ValueChanged<dynamic> onChanged;

  @override
  Widget build(BuildContext context) {
    return CustomDropDown(
      value: value,
      hint: hint,
      items: items
          .map<DropdownMenuItem<String>>((item) => DropdownMenuItem(
              value: item,
              child: Text(
                item,
                style: ProfileStyles.fieldTitleStyle,
              )))
          .toList(),
      onChanged: onChanged,
    );
  }
}
