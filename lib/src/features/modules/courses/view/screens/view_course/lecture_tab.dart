import 'package:auto_size_text/auto_size_text.dart';
import 'package:birds_learning_network/src/features/modules/courses/model/response/db_course_model.dart';
import 'package:birds_learning_network/src/features/modules/courses/view/widgets/lecture_tab_shimmer.dart';
import 'package:birds_learning_network/src/features/modules/courses/view/widgets/lesson_preview.dart';
import 'package:birds_learning_network/src/features/modules/courses/view_model/paid_courses_provider.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/global_model/apis/api_response.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/response_snack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LectureTabWidget extends StatelessWidget {
  const LectureTabWidget({
    super.key, required this.course,
    required this.updateController});

  final Courses course;
  final Function(CourseModel) updateController;

  @override
  Widget build(BuildContext context) {
    const TextStyle style = TextStyle(
        fontSize: 14, fontFamily: "Inter", fontWeight: FontWeight.w400,
        color: deepBlack);
    return Consumer<PaidCoursesProvider>(
      builder: (_, content, __) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child:  content.courseLessons.isEmpty
              ? content.sectionStatus == Status.loading
                ? const LectureTabShimmer()
                : const Padding(
                  padding: EdgeInsets.only(top: 40),
                  child:  Center(
                  child: Text('No available lessons for this course.', style: TextStyle(
                    fontWeight: FontWeight.w500, fontSize: 16, fontFamily: "Inter", color: success900
                  )),
              ),
                )
          : ListView.separated(
            separatorBuilder: (context, index) => const Divider(
              color: success400,
              thickness: 0.7,
            ),
            itemCount: content.currentSections.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              if (content.selectedSection.length < content.currentSections.length) {
                content.selectedSection.add(false);
              }
              return InkWell(
                onTap: () {
                  content.setSelectedSection(index);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: AutoSizeText(
                                "${index + 1}. ${content.currentSections[index].name}",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: style),
                          ),
                          SvgPicture.asset(content.selectedSection[index]
                              ? ImagePath.arrowUpLesson
                              : ImagePath.arrowDownLesson),
                        ],
                      ),
                      ListView.builder(
                          itemCount: content.courseLessons[index].length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int indexx) {
                            return Container(
                              padding: content.selectedSection[index]
                                  ? const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10)
                                  : EdgeInsets.zero,
                              child: content.selectedSection[index]
                                  ? Column(
                                      children: [
                                        LectureLessonPreview(
                                          previousIndex: index,
                                          index: indexx,
                                          lesson: content.courseLessons[index][indexx],
                                          onTap: content.courseLessons[index][indexx].lessonUrl == null ? (){
                                            showSnack(context, "02", "No video for this course");
                                          }
                                            : () {
                                            updateController(content.courseLessons[index][indexx]);
                                          }
                                          // "https://www.youtube.com/watch?v=ZtC7-OpjzOc"
                                        ),
                                      ],
                                    )
                                  : null,
                            );
                          }),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

