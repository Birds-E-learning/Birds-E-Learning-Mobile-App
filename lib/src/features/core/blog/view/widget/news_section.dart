import 'package:birds_learning_network/src/features/core/blog/model/response_model/blog_news_response.dart';
import 'package:birds_learning_network/src/features/modules/home/custom_widgets/html_page.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';

class NewsSectionWidget extends StatelessWidget {
  const NewsSectionWidget({super.key, required this.data});
  final NewsData data;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(data.title ?? "", style: const TextStyle(
            fontWeight: FontWeight.w700, fontSize: 24,
            fontFamily: "Inter", color: success900
          ),),
          const SizedBox(height: 4),
          RichText(text: TextSpan(
              text: 'Article by: ',
              style: const TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.w500,
                  fontSize: 12, color: greys200
              ),
              children: [
                TextSpan(
                    text: data.author ?? "",
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w700,
                        fontFamily: "Inter",
                        decoration: TextDecoration.underline,
                        color: skipColor
                    )
                )
              ]
          )),
          const SizedBox(height: 16),
          HTMLPageScreen(content: data.content ?? ""),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}
