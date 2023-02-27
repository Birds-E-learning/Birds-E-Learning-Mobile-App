import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

dynamic showCountryCode(BuildContext context, ValueChanged<Country> onSelect) {
  return showCountryPicker(
    context: context,
    onSelect: onSelect,
    showPhoneCode: true,
    // countryFilter: ["NG", "US", "UK", "GBP", "GH"]
  );
}
