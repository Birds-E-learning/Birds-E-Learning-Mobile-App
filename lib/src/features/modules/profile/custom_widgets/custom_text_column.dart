import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/auth_styles/auth_style.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/filter_styles/filter_style.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/profile_mixins.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextColumn extends StatelessWidget with AuthStyles, ProfileWidgets {
  const CustomTextColumn({
    required this.controller,
    required this.text,
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
    this.onChanged,
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
  final String text;
  final Widget? suffixIcon;
  final Widget? prefix;
  final bool filled;
  final Color suffixColor;
  final AutovalidateMode autovalidateMode;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        cardTitleStyle(text),
        const SizedBox(height: 5),
        TextFormField(
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
            prefix: prefix,
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
              borderRadius: BorderRadius.circular(filled ? 6 : 4),
              borderSide: BorderSide(
                width: 0.5,
                color: filled ? success500 : deepGrey,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(filled ? 6 : 4),
              borderSide: const BorderSide(
                color: Colors.redAccent,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(filled ? 6 : 4),
              borderSide: const BorderSide(
                color: Colors.redAccent,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(filled ? 6 : 4),
              borderSide: BorderSide(
                width: 0.5,
                color: filled ? success500 : deepGrey,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(filled ? 6 : 4),
              borderSide: BorderSide(
                width: 0.5,
                color: filled ? success500 : deepGrey,
              ),
            ),
          ),
        ),
      ],
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
        suffixIcon: suffixIcon,
        suffixIconColor: suffixColor,
        fillColor: white,
        hintText: hintText,
        hintStyle: FilterStyle.hintStyle,
        isDense: true,
        focusColor: grey100,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: grey100,
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
          borderSide: const BorderSide(
            color: grey100,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(
            color: grey100,
          ),
        ),
      ),
    );
  }
}
