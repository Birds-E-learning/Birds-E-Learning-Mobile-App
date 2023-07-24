import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class HTMLPageScreen extends StatelessWidget {
  const HTMLPageScreen({super.key, required this.content});
  final String content;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Html(
        data: content,
        shrinkWrap: true,
        style: {
          "body": Style(
              margin: Margins.zero,
              fontSize: FontSize(14, Unit.px),
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w400,
              fontFamily: "Inter"),
          "h4": Style(
              color: greys900,
              fontSize: FontSize(18),
              fontFamily: "Inter",
              fontWeight: FontWeight.w700,
              margin: Margins.only(bottom: 5, top: 5, unit: Unit.px)),
          "p": Style(
              margin: Margins.only(top: 0, bottom: 0, unit: Unit.px),
              lineHeight: const LineHeight(0, units: "px"),
              fontSize: FontSize(14),
              color: deepBlack,
              fontFamily: "Inter",
              fontWeight: FontWeight.w400),
          "ul": Style(
              fontSize: FontSize(14),
              display: Display.inline,
              fontFamily: "Inter",
              margin: Margins.all(0, unit: Unit.px)),
          "li": Style(
            lineHeight: const LineHeight(0, units: "px"),
            fontSize: FontSize(14),
            fontFamily: "Inter",
            margin: Margins.all(0, unit: Unit.px),
          ),
        },
      ),
    );
  }
}
