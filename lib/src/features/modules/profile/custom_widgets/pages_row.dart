import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/profile_mixins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomPageRow extends StatelessWidget with ProfileWidgets {
  const CustomPageRow(
      {super.key, required this.icon, required this.text, required this.onTap});
  final String icon;
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SvgPicture.asset(icon),
          const SizedBox(width: 20),
          pageText(text),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios,
            color: success900,
            size: 20,
          )
        ],
      ),
    );
  }
}
