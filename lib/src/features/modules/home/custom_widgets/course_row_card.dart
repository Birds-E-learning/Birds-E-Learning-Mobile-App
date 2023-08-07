import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/modules/home/custom_widgets/course_image.dart';
import 'package:birds_learning_network/src/features/modules/subscription/view/widget/subscription_tag.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/features/modules/home/view/buy_course_screen.dart';
import 'package:birds_learning_network/src/features/modules/user_cart/view_model/cart_provider.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/star_widget.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/home_mixins.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseRowCards extends StatelessWidget with HomeWidgets {
  const CourseRowCards({super.key, required this.course, this.onTap});
  final Courses course;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap ??
          () async {
            course.sections = [];
            RoutingService.pushRouting(
                context, BuyCourseScreen(course: course));
          },
      child: SizedBox(
        // height: 70,
        width: size.width * 0.92,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              width: 55,
              child: CourseImageWidget(course: course,
                  isMore: true,
                  height: 50, width: 50)
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: size.width - (size.width * 0.08) - 70,
                  child: courseTitleText(
                      course.title ?? "Introduction to Technology"),
                ),
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
                Container(
                  child: course.subscriptionBased != null && course.subscriptionBased!
                  ? SubscriptionTagWidget(course: course)
                  : amountText(
                      course.salePrice ?? "5000", course.price ?? "5500"),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future getCourseSection(context, String id) async {
    var response = await Provider.of<CartProvider>(context, listen: false)
        .getCourseSection(context, id);
    if (response != null) {
      List<Sections> sections = response;
      course.sections = sections;
    }
  }
}
