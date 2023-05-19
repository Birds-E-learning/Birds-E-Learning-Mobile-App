import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/modules/courses/view/assessment/assessment_summary.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/text_field.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/star_widget.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/courses_mixins.dart';
import 'package:flutter/material.dart';

class AssessmentTabWidget extends StatefulWidget {
  const AssessmentTabWidget({super.key, required this.course});
  final Courses course;

  @override
  State<AssessmentTabWidget> createState() => _AssessmentTabWidgetState();
}

class _AssessmentTabWidgetState extends State<AssessmentTabWidget>
    with CourseTextWidgets {
  TextEditingController reviewController = TextEditingController();

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListView.builder(
                itemCount: widget.course.sections!.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: AssessmentRow(
                        index: index + 1,
                        section: widget.course.sections![index].name ??
                            "Design Principles"),
                  );
                }),
            const SizedBox(height: 16),
            headerText("Course Review"),
            const SizedBox(height: 16),
            CustomFieldNoLabel(
              controller: reviewController,
              hintText: "Have your say about this course",
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            headerText("Course Rating"),
            const SizedBox(height: 10),
            Row(
              children: getStarListIcon(3, warning300, size: 30),
            ),
          ],
        ),
      ),
    );
  }
}

class AssessmentRow extends StatelessWidget {
  const AssessmentRow({
    super.key,
    required this.index,
    required this.section,
  });
  final dynamic index;
  final String section;

  @override
  Widget build(BuildContext context) {
    const TextStyle style = TextStyle(
        color: grey100,
        fontSize: 8,
        fontWeight: FontWeight.w400,
        fontFamily: "Inter");
    return InkWell(
      onTap: () => RoutingService.pushRouting(
          context, AssessmentSummary(title: section)),
      child: Row(
        children: [
          const Icon(Icons.task, size: 25, color: skipColor),
          const SizedBox(width: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$index  $section",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: deepBlack,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Inter"),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text(
                      "Quiz",
                      style: style,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      height: 2,
                      width: 2,
                      decoration: const BoxDecoration(
                          color: greys200, shape: BoxShape.circle),
                    ),
                    const Text(
                      "4 Questions",
                      style: style,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
