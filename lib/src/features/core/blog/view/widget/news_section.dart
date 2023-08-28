import 'package:birds_learning_network/src/features/core/blog/model/response_model/blog_news_response.dart';
import 'package:birds_learning_network/src/features/core/blog/view/widget/share_widget.dart';
import 'package:birds_learning_network/src/features/modules/home/custom_widgets/html_page.dart';
import 'package:birds_learning_network/src/global_model/repositories/share_plus.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';

class NewsSectionWidget extends StatelessWidget {
  const NewsSectionWidget({super.key, required this.data});
  final NewsData data;

  @override
  Widget build(BuildContext context) {
    String msg = "Here is a blog news i'm sharing to you. Kindly check it out.";
    String url = "https://blns2.dgtechltd.com/";
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
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             const Text('Share news to:', style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w400, color: skipColor,
                fontFamily: "Inter"
              ),),
              const SizedBox(height: 16),
              SizedBox(
                height: 32,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ShareWidget(
                        onPressed: () =>
                            SharePlus.instance.shareToFacebook(context,
                                msg, url: url),
                        imagePath: ImagePath.facebookk),
                    const SizedBox(width: 8),
                    ShareWidget(
                        onPressed: ()=> SharePlus.instance.shareToX(context, msg, url: url),
                        imagePath: ImagePath.x),
                    const SizedBox(width: 8),
                    ShareWidget(
                        onPressed: ()=> SharePlus.instance.shareToLinkedin(context, msg, url: url),
                        imagePath: ImagePath.linkedin),
                    const SizedBox(width: 8),
                    ShareWidget(
                        onPressed: ()=> SharePlus.instance.shareLink(context, msg, url: url),
                        imagePath: ImagePath.link),
                    const SizedBox(width: 16),
                  ],
                ),
              ),
              const SizedBox(height: 30)
            ],
          )
        ],
      ),
    );
  }
}
