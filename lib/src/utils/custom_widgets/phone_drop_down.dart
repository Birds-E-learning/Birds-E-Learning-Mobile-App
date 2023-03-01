import 'package:birds_learning_network/src/global_model/repositories/phone_number.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/auth_styles/auth_style.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class PhoneDropDown extends StatelessWidget {
  const PhoneDropDown({
    super.key,
    required this.onSelect,
    required this.data,
  });
  final ValueChanged<Country> onSelect;
  final String data;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        padding: const EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
            border: Border.all(), borderRadius: BorderRadius.circular(4)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              data,
              style: AuthStyles.labelStyle,
            ),
            IconButton(
                padding: const EdgeInsets.all(0),
                onPressed: () {
                  showCountryCode(context, onSelect);
                }, // showCountryCode(context, onSelect),
                icon: const Icon(Icons.keyboard_arrow_down, size: 30))
          ],
        ));
  }
}
