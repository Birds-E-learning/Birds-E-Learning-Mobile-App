import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/modules/courses/view/screens/view_course/view_course_screen.dart';
import 'package:birds_learning_network/src/features/modules/courses/view_model/paid_courses_provider.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/features/modules/home/view/screens/facilitator.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class CourseRowWidget extends StatelessWidget {
  const CourseRowWidget(
      {super.key, required this.course, required this.percentage});
  final dynamic percentage;
  final Courses course;


  @override
  Widget build(BuildContext context) {
    Courses? currentCourse = context.watch<PaidCoursesProvider>().currentCourse;
    // this is done to dynamically update the course progress on the course screen when the user is watching the course
    // the progress is tracked by checking if the currentCourse is same as the course being displayed
    var progress = currentCourse != null && course.id == currentCourse.id ? currentCourse.progress : null;

    return Consumer<PaidCoursesProvider>(
      builder: (_, ref, __) => InkWell(
        onTap: () async {
          RoutingService.pushRouting(
              context,
              ViewCourseScreen(
                course: course,
              ));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: course.imageUrl!.isEmpty
                          ? Image.asset(
                              ImagePath.thumbnail,
                              fit: BoxFit.fitHeight,
                            ).image
                          : Image.network(course.imageUrl ?? "").image)),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.92 - 110,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 14,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w500,
                        color: black),
                  ),
                  InkWell(
                    onTap: () {
                      RoutingService.pushRouting(
                          context,  FacilitatorScreen(
                        facilitatorId: course.facilitator!.id ?? "0",
                      ));
                    },
                    child: Text(
                      course.facilitator!.name ?? "",
                      style: const TextStyle(
                          fontSize: 10,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.w400,
                          color: greys200),
                    ),
                  )
                ],
              ),
            ),
            percentage.toString() == "0.0" ||
                    percentage.toString() == "0"
                ? const Text(
                    "Start",
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w400,
                        color: success600),
                  )
                : CircularPercentIndicator(
                radius: 20,
                percent: double.parse(progress?.toString() ?? percentage?.toString() ?? "0")/100,
                progressColor: success600,
                backgroundColor: backgroundBlurColor,
                animation: true,
                animationDuration: 800,
                center: Text(
                  "${progress?.toString() ?? percentage ?? 0}%",
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 10.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// CircularProgressIndicator(
// value:  double.parse(percentage.toString())/100,
// color: success600,
// backgroundColor: backgroundBlurColor,
// )