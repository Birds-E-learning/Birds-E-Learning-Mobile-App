import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/features/modules/home/view/facilitator.dart';
import 'package:birds_learning_network/src/features/modules/home/view_model/facilitator_provider.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/global_constants/styles/home_styles/course_style.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/star_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseContainer extends StatelessWidget {
  const CourseContainer({
    super.key,
    required this.course,
  });
  final Courses course;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 200,
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
                  image: course.imageUrl.toString().contains(".com")
                      ? Image.network(
                          course.imageUrl.toString(),
                        ).image
                      : Image.asset(
                          ImagePath.thumbnail,
                        ).image,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover),
              border: Border.all(width: 1, color: borderColor),
              borderRadius: BorderRadius.circular(20)),
        ),
        Container(
          height: 200,
          width: double.infinity,
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
            top: 110,
            left: size.width * 0.04,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: size.width * 0.6,
                    child: Text(
                      course.title ?? "",
                      maxLines: 2,
                      style: const TextStyle(
                          color: white200,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Inter"),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      RichText(
                          text: TextSpan(
                              text: "by  ",
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: "Inter",
                                  fontWeight: FontWeight.w700,
                                  color: white300),
                              children: [
                            TextSpan(
                                text: course.facilitator!.name ?? "Anonymous",
                                style: const TextStyle(
                                    decoration: TextDecoration.underline,
                                    fontSize: 12,
                                    fontFamily: "Inter",
                                    fontWeight: FontWeight.w500,
                                    color: success200),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    context
                                        .read<FacilitatorProvider>()
                                        .getFacilitatorData(context,
                                            course.facilitator!.id!.toString());
                                    RoutingService.pushRouting(
                                        context, const FacilitatorScreen());
                                  }),
                          ])),
                      const SizedBox(width: 5),
                      Row(
                        children: getStarList(course.facilitator!.ratings ?? 0,
                            ImagePath.starFill, ImagePath.starUnfill,
                            size: 12),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "(${course.facilitator!.reviews.toString()})",
                        style: CourseContentStyle.richStyle2
                            .copyWith(color: white),
                      )
                    ],
                  )
                ],
              ),
            ))
      ],
    );
  }
}
