import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/auth_styles/auth_style.dart';
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
  final String labelText;
  final Widget? suffixIcon;
  final Color suffixColor;
  final AutovalidateMode autovalidateMode;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: AuthStyles.headerStyle,
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 50,
          child: TextFormField(
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
              labelStyle: const TextStyle(color: deepGrey, fontFamily: "Inter"),
              suffixIcon: suffixIcon,
              suffixIconColor: suffixColor,
              fillColor: white,
              hintText: hintText,
              hintStyle: AuthStyles.labelStyle,
              isDense: true,
              focusColor: deepGrey,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                  color: deepGrey,
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
                  color: deepGrey,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(
                  color: deepGrey,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}