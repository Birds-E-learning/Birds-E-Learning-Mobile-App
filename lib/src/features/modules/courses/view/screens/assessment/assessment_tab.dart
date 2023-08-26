import 'package:birds_learning_network/src/config/routing/route.dart';
import 'package:birds_learning_network/src/features/modules/courses/model/response/db_course_model.dart';
import 'package:birds_learning_network/src/features/modules/courses/view/screens/assessment/assessment_summary.dart';
import 'package:birds_learning_network/src/features/modules/courses/view_model/paid_courses_provider.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/features/modules/home/view/widgets/shimmer/more_card_shimmer.dart';
import 'package:birds_learning_network/src/global_model/apis/api_response.dart';
import 'package:birds_learning_network/src/utils/custom_widgets/text_field.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/button_white.dart';
import 'package:birds_learning_network/src/utils/mixins/module_mixins/courses_mixins.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AssessmentTabWidget extends StatefulWidget {
  const AssessmentTabWidget({super.key, required this.course, this.updateController});
  final Courses course;
  final Function(CourseModel)? updateController;

  @override
  State<AssessmentTabWidget> createState() => _AssessmentTabWidgetState();
}

class _AssessmentTabWidgetState extends State<AssessmentTabWidget>
    with CourseTextWidgets {
  TextEditingController reviewController = TextEditingController();
  int? rating;

  @override
  void dispose() {
    reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PaidCoursesProvider>(
      builder: (_, content, __) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Container(
               child: content.currentSections.isEmpty ?
                   content.sectionStatus == Status.loading ?
                       ListView.separated(
                         separatorBuilder: (_,__) => const SizedBox(height: 5),
                         itemCount: 3,
                         itemBuilder: (_,__) => const MoreCardsShimmer(),
                         shrinkWrap: true,
                       ) :
                    const Padding(
                     padding: EdgeInsets.only(top: 40),
                     child:  Center(
                       child: Text('No available lessons for this course.', style: TextStyle(
                           fontWeight: FontWeight.w500, fontSize: 16, fontFamily: "Inter", color: success900
                       )),
                     ),
                   ) :
               ListView.builder(
                   itemCount: content.currentSections.length,
                   shrinkWrap: true,
                   physics: const NeverScrollableScrollPhysics(),
                   itemBuilder: (context, int index) {
                     return Padding(
                       padding: const EdgeInsets.only(bottom: 20),
                       child: AssessmentRow(
                            onTap: (){
                              if(widget.updateController != null){
                                widget.updateController!(CourseModel(
                                  pauseVideo: true,
                                ));
                              }
                              RoutingService.pushRouting(
                                  context,
                                  AssessmentSummary(title: content.currentSections[index].name ?? ""));
                            },
                           index: index + 1,
                           section: content.currentSections[index].name ?? ""),
                     );
                   }),
             ),
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
              SizedBox(
                height: 50,
                child: ListView.separated(
                  itemCount: 5,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  separatorBuilder: (_,__) => const SizedBox(height: 4),
                  itemBuilder: (_, index) =>
                 GestureDetector(
                   onTap: (){
                     rating = index;
                     setState(() {});
                   },
                   child: rating != null && rating! >= index ?
                   const Icon(Icons.star, size: 40, color: warning300) :
                   const Icon(Icons.star_border_sharp, size: 40, color: warning300),
                 )
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: WhiteButtonWidget(
                    onPressed: () {},
                    child: const Text("Save Review",
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: skipColor),
                    ),
                ),
              ),
            ],
          ),
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
    this.onTap,
  });
  final dynamic index;
  final String section;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    const TextStyle style = TextStyle(
        color: grey100,
        fontSize: 8,
        fontWeight: FontWeight.w400,
        fontFamily: "Inter");
    return InkWell(
      onTap: onTap ?? () => RoutingService.pushRouting(
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
