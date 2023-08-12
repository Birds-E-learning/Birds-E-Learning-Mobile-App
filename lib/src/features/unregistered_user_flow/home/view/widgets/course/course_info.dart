import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/features/modules/home/view/screens/facilitator.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/star_widget.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/content_mixins.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/home_mixins.dart';
import 'package:flutter/material.dart';

class CourseInfoWidget extends StatelessWidget with HomeWidgets, ContentWidget {
  const CourseInfoWidget(
      {super.key, required this.course, this.isFacilitator = false});
  final Courses course;
  final bool isFacilitator;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: size.width * 0.6, child: titleText(course.title ?? "")),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: success100, borderRadius: BorderRadius.circular(20)),
              child: titleAmountText(course.salePrice ?? ""),
            )
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            contentOwnerText(
                course.facilitator!.name == ""
                    ? "Anonymous"
                    : course.facilitator!.name!, () {
              if (isFacilitator) {
                RoutingService.popRouting(context);
              } else {
                RoutingService.pushRouting(context, FacilitatorScreen(
                  facilitatorId: course.facilitator!.id ?? "",
                ));
              }
            }),
            const SizedBox(width: 5),
            Row(
              children: getStarList(course.facilitator!.ratings ?? 0,
                  ImagePath.starFill, ImagePath.starUnfill,
                  size: 12),
            ),
            const SizedBox(width: 5),
            ratingText(course.facilitator!.reviews ?? 0)
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            benefitText(
                "${course.duration} total minutes video", Icons.play_circle),
            const SizedBox(width: 15),
            benefitText("Resource files", Icons.assessment)
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            benefitText("Certificate of Completion", Icons.leaderboard),
            const SizedBox(width: 15),
            benefitText("Lifetime access", Icons.all_inclusive)
          ],
        ),
      ],
    );
  }
}
