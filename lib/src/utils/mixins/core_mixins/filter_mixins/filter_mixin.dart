import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/filter_styles/filter_style.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/core_texts/filter_texts.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

mixin FilterTextWidgets on Object implements FilterTexts, FilterStyle {
  Text getStartedButtonText() {
    return const Text(
      FilterTexts.getStartedText,
      style: FilterStyle.buttonStyle,
    );
  }

  Text doneButtonText() {
    return const Text(
      "Done",
      style: FilterStyle.buttonStyle,
    );
  }

  Text skipButtonText() {
    return Text(
      FilterTexts.skipText,
      style: FilterStyle.buttonStyle.copyWith(color: skipColor),
    );
  }

  Text proceedButtonText() {
    return const Text(
      FilterTexts.proceedButtonText,
      style: FilterStyle.buttonStyle,
    );
  }

  Text filterHeader() {
    return const Text(
      FilterTexts.filterHeader,
      textAlign: TextAlign.center,
      style: FilterStyle.filterHeaderStyke,
    );
  }

  Text startedHeader() {
    return const Text(
      FilterTexts.getYouStarted,
      textAlign: TextAlign.center,
      style: FilterStyle.filterHeaderStyke,
    );
  }

  Text filterText() {
    return const Text(
      FilterTexts.filterText,
      textAlign: TextAlign.center,
      style: FilterStyle.filterTextStyle,
    );
  }

  Text startedText() {
    return const Text(
      FilterTexts.profileSetup,
      textAlign: TextAlign.center,
      style: FilterStyle.filterTextStyle,
    );
  }

  Text hintText() {
    return const Text(
      FilterTexts.hintText,
      style: FilterStyle.hintStyle,
    );
  }

  Container topicText(String topic, Color backgroundColor, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: deepBlack)),
      child: Text(
        topic,
        textAlign: TextAlign.center,
        style: FilterStyle.topicStyle.copyWith(color: backgroundColor),
      ),
    );
  }

  Align setupProfile(VoidCallback onTap) {
    return Align(
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(children: [
          const TextSpan(
            text: FilterTexts.proceedText,
            style: FilterStyle.setupStyle,
          ),
          TextSpan(
              text: FilterTexts.profileText,
              style: FilterStyle.setupStyle.copyWith(color: success800),
              recognizer: TapGestureRecognizer()..onTap = onTap)
        ]),
      ),
    );
  }
}
