import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/auth_styles/auth_style.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

dynamic showCountryCode(BuildContext context, ValueChanged<Country> onSelect) {
  return showCountryPicker(
    context: context,
    onSelect: onSelect,
    countryListTheme: CountryListThemeData(
      inputDecoration: InputDecoration(
        labelText: "Search",
        labelStyle: AuthStyles.labelStyle,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: deepGrey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: deepGrey,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: deepGrey,
          ),
        ),
      ),
    ),
    showPhoneCode: true,
    // countryFilter: ["NG", "US", "UK", "GBP", "GH"]
  );
}
