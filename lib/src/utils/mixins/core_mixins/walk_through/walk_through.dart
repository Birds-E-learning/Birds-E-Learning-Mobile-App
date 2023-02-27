import 'package:auto_size_text/auto_size_text.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/text_style.dart';
import 'package:birds_learning_network/src/utils/global_constants/texts/core_texts/walk_through.dart';
import 'package:flutter/material.dart';

mixin WalkThroughTextWidget on Object implements WalkThroughTexts, TextStyles {
  AutoSizeText walkText1() {
    return const AutoSizeText(
      WalkThroughTexts.walkThrough1,
      style: TextStyles.walkthroughStyle,
      textAlign: TextAlign.center,
      maxLines: 2,
    );
  }

  AutoSizeText walkTex2() {
    return const AutoSizeText(
      WalkThroughTexts.walkThrough2,
      style: TextStyles.walkthroughStyle,
      textAlign: TextAlign.center,
      maxLines: 2,
    );
  }

  AutoSizeText walkText3() {
    return const AutoSizeText(
      WalkThroughTexts.walkThrough3,
      style: TextStyles.walkthroughStyle,
      textAlign: TextAlign.center,
      maxLines: 2,
    );
  }

  Text skipButtonText() {
    return const Text(
      WalkThroughTexts.skip,
      style: TextStyles.buttonStyle,
    );
  }

  Text nextButtonText() {
    return Text(
      WalkThroughTexts.next,
      style: TextStyles.buttonStyle.copyWith(color: nextColor),
    );
  }
}
