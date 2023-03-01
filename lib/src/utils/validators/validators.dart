import 'package:birds_learning_network/src/global_model/repositories/email_validator.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';

class InputValidators {
  dynamic nameValidator(String? value, type) {
    final RegExp nameRegExp = RegExp('[a-zA-Z]');
    if (value!.isEmpty) {
      return "$type name must be filled";
    } else if (nameRegExp.hasMatch(value)) {
      return "Enter a valid name";
    }
    return null;
  }

  dynamic passwordValidator(String? value) {
    if (value!.isEmpty) {
      return "Password must be filled";
    } else if (value.length < 5) {
      return "Password must be at least 5 digits";
    }
    return null;
  }

  dynamic emailValidator(String? value) {
    if (value!.isEmpty) {
      return "Email address must be field";
    } else if (!validateEmail(value)) {
      return "Enter a valid email address";
    }
    return null;
  }

  dynamic numberValidator(String? value) {
    if (value!.isEmpty) {
      return "Phone number must be filled";
    }
    return null;
  }

  IconButton passwordVisibility(VoidCallback onPressed, bool showPassword) {
    return IconButton(
      onPressed: onPressed,
      icon: !showPassword
          ? const Icon(Icons.visibility_off_outlined, color: blackSolid)
          : const Icon(Icons.visibility_outlined, color: blackSolid),
    );
  }
}
