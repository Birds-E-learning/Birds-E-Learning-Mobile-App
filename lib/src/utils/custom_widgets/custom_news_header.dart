import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TitleHeader extends StatelessWidget {
  const TitleHeader({super.key,
    required this.image,
    required this.title
  });
  final String title;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
          color: grey700
        ),),
        const SizedBox(height: 5),
        SvgPicture.asset(image),
      ],
    );
  }
}
