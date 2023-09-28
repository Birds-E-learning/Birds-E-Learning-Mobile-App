import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/filter_styles/filter_style.dart';
import 'package:flutter/material.dart';

class PreferenceCards extends StatelessWidget {
  const PreferenceCards({
    super.key,
    required this.color,
    required this.backgroundColor,
    required this.topic
  });
  final Color color;
  final Color backgroundColor;
  final String topic;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: deepBlack)),
      child: Text(
        topic,
        textAlign: TextAlign.center,
        style: FilterStyle.topicStyle.copyWith(color: backgroundColor),
      ),
    );
  }
}
