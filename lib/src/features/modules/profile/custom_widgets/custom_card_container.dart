import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/profile_mixins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CardContainer extends StatelessWidget with ProfileWidgets {
  const CardContainer({
    super.key,
    required this.image,
    required this.text,
    required this.onTap,
  });
  final VoidCallback onTap;
  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: greys800)),
        child: Row(
          children: [
            SvgPicture.asset(image),
            const SizedBox(width: 15),
            cardLabelText(text)
          ],
        ),
      ),
    );
  }
}

class CardRowContainer extends StatelessWidget with ProfileWidgets {
  const CardRowContainer({
    super.key,
    required this.image,
    required this.text,
    required this.onTap,
  });
  final VoidCallback onTap;
  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: greys800)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(image),
              const SizedBox(width: 10),
              cardLabelText(text)
            ],
          ),
        ),
      ),
    );
  }
}
