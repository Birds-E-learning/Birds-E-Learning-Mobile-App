import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/home/view/screens/buy_course_screen.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/star_widget.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/home_mixins.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UnregisteredCourseCard extends StatelessWidget with ImagePath, HomeWidgets {
  const UnregisteredCourseCard({
    super.key,
    required this.course,
  });
  final Courses course;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        course.sections = <Sections>[];
        RoutingService.pushFullScreenRouting(
            context, UnregisteredBuyCourseScreen(course: course));
      },
      child: Container(
        width: 165,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1,
              color: grey100,
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
                height: 90,
                width: 165,
                child: CachedNetworkImage(
                  imageUrl: course.imageUrl ?? "",
                  imageBuilder: (context, imageProvider) => Container(
                    height: 90,
                    width: 165,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
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
                    height: 90,
                    width: 165,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                        image: Image.asset(ImagePath.thumbnail).image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                children: [
                  SizedBox(
                    width: size.width - (size.width * 0.08) - 60,
                    child: courseTitleText(course.title ?? ""),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ownerText(course.facilitator!.name == ""
                              ? "Anonymous"
                              : course.facilitator!.name!),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Row(
                                children: getStarList(
                                    course.facilitator!.ratings ?? "1",
                                    ImagePath.starFill,
                                    ImagePath.starUnfill),
                              ),
                              const SizedBox(width: 10),
                              ratingText(course.facilitator!.reviews.toString())
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  amountText(course.salePrice ?? "5000", course.price ?? "5500")
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
