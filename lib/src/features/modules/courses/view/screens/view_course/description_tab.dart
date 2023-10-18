import 'package:birds_learning_network/src/features/modules/courses/view_model/paid_courses_provider.dart';
import 'package:birds_learning_network/src/features/modules/home/custom_widgets/html_page.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class CourseDescriptionTab extends StatelessWidget {
  const CourseDescriptionTab({super.key, required this.course});
  final Courses course;

  @override
  Widget build(BuildContext context) {
    return Consumer<PaidCoursesProvider>(
      builder: (_,ref, __) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: success1000)
                ),
                child: LinearPercentIndicator( //leaner progress bar
                  animation: true,
                  animationDuration: 800,
                  lineHeight: 15.0,
                  percent: double.parse(ref.currentCourse?.progress.toString()
                      ?? course.progress?.toString() ?? "0")/100,
                  center: Text(
                    "${ref.currentCourse?.progress ?? course.progress ?? 0}%",
                    style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  barRadius: const Radius.circular(20),
                  progressColor: success600,
                  backgroundColor: backgroundBlurColor,
                ),
              ),
              const SizedBox(height: 20),
              HTMLPageScreen(
                content: ref.currentCourse?.content ?? course.content ?? "",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
