import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/features/modules/home/view/buy_course_screen.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/star_widget.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/home_mixins.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FacilitatorCourseCards extends StatelessWidget with HomeWidgets {
  const FacilitatorCourseCards({super.key, required this.course, this.onTap});
  final Courses course;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        course.sections = <Sections>[];
        RoutingService.pushRouting(
            context, BuyCourseScreen(course: course, isFcilitator: true));
      },
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
                  height: 40,
                  width: 50,
                  child: CachedNetworkImage(
                    height: 50,
                    width: 50,
                    fit: BoxFit.fill,
                    imageUrl: course.imageUrl ?? "",
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
                        ownerText(
                            course.facilitator!.name ?? "Anonymous"),
                        const SizedBox(width: 5),
                        Row(
                          children: getStarList(
                             course.facilitator!.ratings ?? "3",
                              ImagePath.starFill,
                              ImagePath.starUnfill),
                        ),
                        const SizedBox(width: 5),
                        ratingText(course.facilitator!.ratings ?? "3")
                      ],
                    ),
                    const SizedBox(height: 3),
                    amountText(course.salePrice ?? "5000",
                        course.price ?? "5500")
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

}
