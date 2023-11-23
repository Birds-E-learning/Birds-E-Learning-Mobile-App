import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';

SizedBox checkBox(bool checked, ValueChanged<bool?> onChanged) {
  return SizedBox(
    height: 17,
    width: 17,
    child: Checkbox(
      value: checked,
      activeColor: grey500,
      side: const BorderSide(color: grey500),
      onChanged: onChanged,
    ),
  );
}
