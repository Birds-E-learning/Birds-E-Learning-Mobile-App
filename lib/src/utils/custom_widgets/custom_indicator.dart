import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';

class CustomIndicator extends StatelessWidget {
  const CustomIndicator({
    super.key,
    this.activeColor = activeDottColor,
    this.color = inactiveDotColor,
    required this.count,
    required this.position,
  });
  final int count;
  final int position;
  final Color activeColor;
  final Color color;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: DotsIndicator(
        dotsCount: count,
        position: position.toDouble(),
        decorator: DotsDecorator(
          activeColor: success600,
          color: success200,
          size: const Size.square(8),
          spacing: const EdgeInsets.symmetric(horizontal: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          activeSize: const Size(16, 8),
          activeShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}
