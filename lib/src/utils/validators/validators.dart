import 'package:birds_learning_network/src/global_model/repositories/email_validator.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';

class InputValidators {
  dynamic nameValidator(String? value, type) {
    final RegExp nameRegExp = RegExp('[a-zA-Z]');
    if (value!.isEmpty) {
      return "$type name is required";
    } else if (!nameRegExp.hasMatch(value)) {
      return "Enter a valid name";
    }
    return null;
  }

  dynamic passwordValidator(String? value) {
    if (value!.isEmpty) {
      return "Password is required";
    } else if (value.length < 8) {
      return "Password must be 8 characters or more";
    }
    return null;
  }

  dynamic newPasswordValidator(String? value, String password) {
    if (value!.isEmpty) {
      return "Password is required";
    } else if (value.length < 8) {
      return "Password must be 8 characters or more";
    } else if (value == password) {
      return "New Password should not be same as Old Password";
    }
    return null;
  }

  dynamic confirmPasswordValidator(String? value, String password) {
    if (value!.isEmpty) {
      return "Password is required";
    } else if (value != password) {
      return "Password mismatch";
    }
    return null;
  }

  dynamic emailValidator(String? value) {
    if (value!.isEmpty) {
      return "Email address is required";
    } else if (!validateEmail(value)) {
      return "Enter a valid email address";
    }
    return null;
  }

  dynamic numberValidator(String? value) {
    if (value!.isEmpty) {
      return "Phone number is required";
    }
    return null;
  }

  IconButton passwordVisibility(VoidCallback onPressed, bool showPassword) {
    return IconButton(
      onPressed: onPressed,
      icon: showPassword
          ? const Icon(Icons.visibility_off_outlined, color: blackSolid)
          : const Icon(Icons.visibility_outlined, color: blackSolid),
    );
  }
}
