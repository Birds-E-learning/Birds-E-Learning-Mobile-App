import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CourseImageWidget extends StatelessWidget {
  const CourseImageWidget({super.key, required this.course,
    this.height = 90,
    this.width = 165,
    this.isMore = false
  });
  final Courses course;
  final double height;
  final double width;
  final bool isMore;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: course.imageUrl ?? "",
      imageBuilder: (context, imageProvider) => Container(
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
      placeholder: (context, url) => const Center(
          child: SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator())),
      errorWidget: (context, url, error) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
            image: Image.asset(ImagePath.thumbnail).image,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
