import 'package:birds_learning_network/src/global_model/services/native_app/cached_image.dart';
import 'package:flutter/material.dart';

class CourseImageWidget extends StatelessWidget {
  const CourseImageWidget({super.key, required this.imageUrl,
    this.height = 90,
    this.width = 165,
    this.isMore = false
  });
  final String imageUrl;
  final double height;
  final double width;
  final bool isMore;

  @override
  Widget build(BuildContext context) {
    return CachedImage(
      imageUrl: imageUrl,
      imageBuilder:(context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: isMore ?  BorderRadius.circular(10): const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10)),
          color: Colors.transparent,
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.fill,
          ),
        ),
      ),
      // errorWidget: Container(
      //   height: height,
      //   width: width,
      //   decoration: BoxDecoration(
      //     color: Colors.transparent,
      //     image: DecorationImage(
      //       image: Image.asset(ImagePath.thumbnail).image,
      //       fit: BoxFit.fill,
      //     ),
      //   ),
      // ),
    );
  }
}
