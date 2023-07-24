import 'package:auto_size_text/auto_size_text.dart';
import 'package:birds_learning_network/src/features/modules/courses/view_model/paid_courses_provider.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LectureTabWidget extends StatelessWidget {
  const LectureTabWidget({super.key, required this.course});
  final Courses course;

  @override
  Widget build(BuildContext context) {
    const TextStyle style = TextStyle(
        fontSize: 14,
        fontFamily: "Inter",
        fontWeight: FontWeight.w400,
        color: deepBlack);
    return Consumer<PaidCoursesProvider>(
      builder: (_, content, __) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: ListView.separated(
            separatorBuilder: (context, index) => const Divider(
              color: success400,
              thickness: 0.7,
            ),
            itemCount: course.sections!.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              if (content.selectedSection.length < course.sections!.length) {
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
                                "${index + 1}. ${course.sections![index].name}",
                                maxLines: 2,
                                style: style),
                          ),
                          SvgPicture.asset(content.selectedSection[index]
                              ? ImagePath.arrowUpLesson
                              : ImagePath.arrowDownLesson),
                        ],
                      ),
                      ListView.builder(
                          itemCount: course.sections![index].lessons!.length,
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
                                          lesson: course.sections![index]
                                              .lessons![indexx],
                                          name: course.sections![index]
                                              .lessons![0].name!,
                                          isPreview: false,
                                          onTap: () {},
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

class LectureLessonPreview extends StatelessWidget {
  const LectureLessonPreview(
      {super.key,
      required this.index,
      required this.previousIndex,
      required this.lesson,
      this.name = "Preview Preview lesson",
      required this.onTap,
      this.isPreview = true});
  final dynamic index;
  final dynamic previousIndex;
  final String name;
  final Lessons lesson;
  final bool isPreview;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const TextStyle subStyle = TextStyle(
        fontSize: 10,
        fontFamily: "Inter",
        fontWeight: FontWeight.w400,
        color: greys300);
    const TextStyle style = TextStyle(
        fontSize: 14,
        fontFamily: "Inter",
        fontWeight: FontWeight.w400,
        color: deepBlack);
    String lessonName = name.split(" ").sublist(1).join(" ");
    dynamic minute = (int.parse(lesson.duration.toString()) / 60).floor();
    dynamic seconds = int.parse(lesson.duration.toString()) % 60;
    String minText = minute > 1 ? "minutes" : "minute";
    String secText = seconds > 1 ? "seconds" : "second";

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: AutoSizeText(
                isPreview
                    ? lessonName
                    : "${previousIndex + 1}.${index + 1} $lessonName",
                maxLines: 2,
                style: style,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, left: 10),
              child: Row(
                children: [
                  const Text(
                    "video",
                    style: subStyle,
                  ),
                  const SizedBox(width: 5),
                  Container(
                    height: 6,
                    width: 6,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: greys300),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "$minute $minText $seconds $secText",
                    style: subStyle,
                  )
                ],
              ),
            )
          ],
        ),
        IconButton(
          onPressed: onTap,
          icon: const Icon(
            Icons.play_circle,
            size: 20,
            color: deepBlack,
          ),
        )
      ],
    );
  }
}
