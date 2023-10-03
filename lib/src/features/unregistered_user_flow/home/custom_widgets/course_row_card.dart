import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/course/view_model/course_provider.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/home/view/screens/buy_course_screen.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/star_widget.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/home_mixins.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UnregisteredCourseRowCards extends StatelessWidget with HomeWidgets {
  const UnregisteredCourseRowCards({super.key, required this.course, this.onTap});
  final Courses course;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ??
          () async {
            course.sections = [];
            RoutingService.pushRouting(
                context, UnregisteredBuyCourseScreen(course: course));
          },
      child: SizedBox(
        // height: 70,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                  width: 55,
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      courseTitleText(
                          course.title ?? "Introduction to Technology"),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          ownerText(course.facilitator!.name ?? "Anonymous"),
                          const SizedBox(width: 5),
                          Row(
                            children: getStarList(
                                course.facilitator!.ratings.toString(),
                                ImagePath.starFill,
                                ImagePath.starUnfill),
                          ),
                          const SizedBox(width: 5),
                          ratingText(course.facilitator!.reviews == ""
                              ? "4"
                              : course.facilitator!.reviews.toString())
                        ],
                      ),
                      const SizedBox(height: 3),
                      amountText(
                          course.salePrice ?? "5000", course.price ?? "5500")
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future getCourseSection(context, String id) async {
    var response = await Provider.of<UnregisteredCourseProvider>(context, listen: false)
        .getCourseSection(context, id);
    if (response != null) {
      List<Sections> sections = response;
      course.sections = sections;
    }
  }
}
