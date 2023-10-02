import 'package:auto_size_text/auto_size_text.dart';
import 'package:birds_learning_network/src/features/modules/courses/model/response/db_course_model.dart';
import 'package:birds_learning_network/src/features/modules/courses/view_model/paid_courses_provider.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LectureLessonPreview extends StatelessWidget {
  const LectureLessonPreview(
      {super.key,
        required this.index,
        required this.previousIndex,
        required this.lesson,
        required this.onTap});
  final dynamic index;
  final dynamic previousIndex;
  final CourseModel lesson;
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
    String lessonName = lesson.lessonTitle!.split(" ").sublist(1).join(" ");
    dynamic minute = (int.parse(lesson.lessonDuration.toString()) / 60).floor();
    dynamic seconds = int.parse(lesson.lessonDuration.toString()) % 60;
    String minText = minute > 1 ? "minutes" : "minute";
    String secText = seconds > 1 ? "seconds" : "second";

    return Consumer<PaidCoursesProvider>(
      builder: (_, provider, __) => Container(
        padding: const EdgeInsets.only(
          left: 8, top: 8, bottom: 8
        ),
        // change this to current playing ID  which has the concatenation of the "video id, section id and lesson id"
        decoration: BoxDecoration(
          color: provider.currentlyPlayingLesson != null &&
              provider.currentlyPlayingLesson!.sectionId == lesson.sectionId &&
              provider.currentlyPlayingLesson!.lessonId == lesson.lessonId
              ? success300 : white,
          borderRadius: BorderRadius.circular(8)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: AutoSizeText(
                        "${previousIndex + 1}.${index + 1} $lessonName",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
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
                      ),
                      const SizedBox(width: 5),
                      Container(
                        child: lesson.progress.toString() == "100.0"
                            || lesson.progress.toString() == "100"
                            || (provider.lessonProgress == 100 && lesson.lessonId == provider.currentlyPlayingLesson?.lessonId)
                        ? const Icon(Icons.check_circle, color: success600, size: 14)
                        : null
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
        ),
      ),
    );
  }
}
