import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShareWidget extends StatelessWidget {
  const ShareWidget({super.key,
    required this.onPressed,
    required this.imagePath
  });
  final String imagePath;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 32,
        width: 32,
        decoration: BoxDecoration(
           // shape: BoxShape.circle,
           borderRadius: BorderRadius.circular(30),
          border: Border.all(color: grey100)
        ),
        child: Padding(
          padding: const EdgeInsets.all(4),
            child: SvgPicture.asset(imagePath,)),
      ),
    );
  }
}
