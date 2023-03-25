import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses_pref.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/star_widget.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/home_mixins.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CourseRowCards extends StatelessWidget with HomeWidgets {
  const CourseRowCards({super.key, required this.course, required this.onTap});
  final CoursesPref course;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        // height: 70,
        width: size.width * 0.92,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                  width: 50,
                  child: CachedNetworkImage(
                    imageUrl:
                        course.imageId != null ? course.imageId.toString() : "",
                    // "https://birds-e-learning.herokuapp.com/img/profile.png",
                    // imageBuilder: (context, imageProvider) {
                    //   return Image(image: NetworkImage(course.imageId ?? ""));
                    // },
                    placeholder: (context, url) {
                      return Image.asset(
                        ImagePath.titlePics,
                        fit: BoxFit.fill,
                      );
                    },
                    errorWidget: (context, url, error) {
                      return Image.asset(
                        ImagePath.titlePics,
                        fit: BoxFit.fill,
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width - (size.width * 0.08) - 60,
                      child: courseTitleText(
                          course.title ?? "Introduction to Technology"),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        ownerText("John Doe"),
                        const SizedBox(width: 5),
                        Row(
                          children: getStarList(
                              "3", ImagePath.starFill, ImagePath.starUnfill),
                        ),
                        const SizedBox(width: 5),
                        ratingText(course.reviewScore ?? "4,103")
                      ],
                    ),
                    const SizedBox(height: 3),
                    amountText(course.salePrice ?? "NGN5000",
                        course.price ?? "NGN5500")
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10,
              child: Divider(
                thickness: 0.2,
                color: success1000,
              ),
            )
          ],
        ),
      ),
    );
  }
}
