import 'package:auto_size_text/auto_size_text.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/features/modules/home/view_model/course_content_provider.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SectionCard extends StatelessWidget {
  const SectionCard(
      {super.key,
      required this.index,
      required this.section,
      required this.onPlayTap,
      required this.onLessonTap});
  final dynamic index;
  final Sections section;
  final VoidCallback onPlayTap;
  final VoidCallback onLessonTap;
  @override
  Widget build(BuildContext context) {
    const TextStyle style = TextStyle(
        fontSize: 14,
        fontFamily: "Inter",
        fontWeight: FontWeight.w400,
        color: deepBlack);

    return Consumer<CourseContentProvider>(
      builder: (_, content, __) => InkWell(
        onTap: onLessonTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 7.5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: AutoSizeText("${index + 1}. ${section.name}",
                        maxLines: 2, style: style),
                  ),
                  Icon(
                    content.selectedLesson[index]
                    ? Icons.keyboard_arrow_up_outlined
                    : Icons.keyboard_arrow_down_outlined,
                    color: black, size: 30,)
                ],
              ),
              ListView.builder(
                  itemCount: section.lessons!.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int indexx) {
                    return Container(
                      padding: content.selectedLesson[index]
                          ? const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10)
                          : EdgeInsets.zero,
                      child: content.selectedLesson[index]
                          ? Column(
                              children: [
                                Container(
                                  child: index == 0 && indexx == 0
                                      ? LessonPreview(
                                          previousIndex: index,
                                          index: indexx,
                                          lesson: section.lessons![indexx],
                                          onTap: onPlayTap,
                                        )
                                      : null,
                                ),
                                SizedBox(height: index == 0 ? 15 : 0),
                                LessonPreview(
                                  previousIndex: index,
                                  index: indexx,
                                  lesson: section.lessons![indexx],
                                  name: section.lessons![0].name!,
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
      ),
    );
  }
}

class LessonPreview extends StatelessWidget {
  const LessonPreview(
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
          icon: Icon(
            Icons.play_circle,
            size: 20,
            color: !isPreview ? greys300 : deepBlack,
          ),
        )
      ],
    );
  }
}

 // Container(
              // padding: content.selectedLesson[index]
              //     ? const EdgeInsets.symmetric(horizontal: 15, vertical: 5)
              //     : EdgeInsets.zero,
              //   child: content.selectedLesson[index]
              // ? Column(
              //     children: [
              //       Container(
              //         child: index == 0
              //             ? LessonPreview(
              //                 index: index,
              //                 lesson: section.lessons![0],
              //                 onTap: onPlayTap,
              //               )
              //             : null,
              //       ),
              //       SizedBox(height: index == 0 ? 15 : 0),
              //       LessonPreview(
              //         index: index,
              //         lesson: section.lessons![0],
              //         name:
              //             section.lessons![0].name ?? "lesson unavailable",
              //         isPreview: false,
              //         onTap: () {},
              //       ),
              //     ],
              //   )
              //       : null,
              // ),
              // const Padding(
              //   padding: EdgeInsets.symmetric(vertical: 15),
              //   child: Divider(
              //     color: success400,
              //     thickness: 0.7,
              //   ),
              // )