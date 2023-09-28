import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/auth_styles/auth_style.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/filter_styles/filter_style.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/home_styles/home_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget with AuthStyles {
  const CustomTextField({
    required this.controller,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.inputFormatters,
    this.validator,
    this.readOnly = false,
    this.hintText = "",
    this.obscureText = false,
    this.suffixColor = strokeColor,
    this.suffixIcon,
    this.prefix,
    this.filled = false,
    this.maxLines = 1,
    this.minLines,
    this.width = 0.5,
    this.bordercolor = deepGrey,
    super.key,
  });
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final Color bordercolor;
  final bool readOnly;
  final int maxLines;
  final int? minLines;
  final String hintText;
  final String labelText;
  final Widget? suffixIcon;
  final Widget? prefix;
  final bool filled;
  final double width;
  final Color suffixColor;
  final AutovalidateMode autovalidateMode;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      obscureText: obscureText,
      autovalidateMode: autovalidateMode,
      inputFormatters: inputFormatters,
      readOnly: readOnly,
      maxLines: maxLines,
      minLines: minLines,
      style: const TextStyle(fontFamily: "Inter"),
      decoration: InputDecoration(
        prefix: prefix,
        labelText: labelText,
        labelStyle: AuthStyles.labelStyle,
        suffixIcon: suffixIcon,
        suffixIconColor: suffixColor,
        filled: filled,
        fillColor: filled ? backgroundBlurColor : white,
        hintText: hintText,
        hintStyle: AuthStyles.labelStyle,
        isDense: true,
        focusColor: deepGrey,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            width: width,
            color: filled ? success500 : bordercolor,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(
            color: Colors.redAccent,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: const BorderSide(
            color: Colors.redAccent,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            width: width,
            color: filled ? success500 : bordercolor,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(
            width: width,
            color: filled ? success500 : bordercolor,
          ),
        ),
      ),
    );
  }
}

class CustomFieldNoLabel extends StatelessWidget with AuthStyles {
  const CustomFieldNoLabel({
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.inputFormatters,
    this.validator,
    this.readOnly = false,
    this.hintText = "",
    this.obscureText = false,
    this.suffixColor = strokeColor,
    this.suffixIcon,
    this.maxLines = 1,
    this.minLines,
    this.isHome = false,
    this.onChanged,
    this.prefixIcon,
    super.key,
  });
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final FormFieldValidator<String>? validator;
  final bool obscureText;
  final bool readOnly;
  final int maxLines;
  final int? minLines;
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color suffixColor;
  final bool isHome;
  final ValueChanged<String>? onChanged;
  final AutovalidateMode autovalidateMode;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      obscureText: obscureText,
      autovalidateMode: autovalidateMode,
      inputFormatters: inputFormatters,
      readOnly: readOnly,
      maxLines: maxLines,
      minLines: minLines,
      onChanged: onChanged,
      style: const TextStyle(fontFamily: "Inter"),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        suffixIconColor: suffixColor,
        prefixIcon: prefixIcon,
        prefixIconColor: deepBlack,
        fillColor: white,
        hintText: hintText,
        hintStyle: isHome ? HomeStyles.hintStyle : FilterStyle.hintStyle,
        isDense: true,
        focusColor: isHome ? greys800 : grey100,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            width: 1,
            color: isHome ? greys800 : grey100,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: Colors.redAccent,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: Colors.redAccent,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            width: 1,
            color: isHome ? greys800 : grey100,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
            width: 1,
            color: isHome ? greys800 : grey100,
          ),
        ),
      ),
    );
  }
}
