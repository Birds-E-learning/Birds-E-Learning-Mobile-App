import 'package:birds_learning_network/src/features/core/blog/model/response_model/blog_news_response.dart';
import 'package:birds_learning_network/src/global_model/services/native_app/cached_image.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';

class UnregisteredNewsContainer extends StatelessWidget {
  const UnregisteredNewsContainer({super.key,
    required this.data
  });
  final NewsData data;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        CachedImage(
          imageUrl: data.imageUrl ?? "",
          imageBuilder: (context, imageProvider) => Container(
            alignment: Alignment.center,
            height: 207,
            width: size.width > 400 ? 341 : size.width * 0.90,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 44),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    spreadRadius: 2,
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
                image: DecorationImage(
                    onError: (_, __)=> Image.asset(ImagePath.thumbnail),
                    image: imageProvider
                ),
                borderRadius: BorderRadius.circular(20)
            ),
          ),
        ),
        Container(
          height: 207,
          width: size.width > 400 ? 341 : size.width * 0.90,
          decoration: BoxDecoration(
              color: Colors.black,
              gradient: const LinearGradient(
                colors: [
                  Color.fromRGBO(0, 0, 0, 0),
                  gradient,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              border: Border.all(width: 1, color: borderColor),
              borderRadius: BorderRadius.circular(20)),
        ),
        Positioned(
          bottom: 40,
          left: 40,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width > 300 ? 240 : size.width * 0.8,
                child: Text(
                  data.title ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Inter',
                      color: Color.fromRGBO(255, 255, 255, 1)
                  ),
                ),
              ),
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
                      color: skipColor
                    )
                  )
                ]
              ))
            ],
          ),
        )
      ],
    );
  }
}
