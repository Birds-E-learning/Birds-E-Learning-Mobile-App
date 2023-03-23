import 'package:auto_size_text/auto_size_text.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses_pref.dart';
import 'package:birds_learning_network/src/features/modules/home/view_model/course_content_provider.dart';
import 'package:birds_learning_network/src/utils/global_constants/asset_paths/image_path.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/response_snack.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class LessonCard extends StatelessWidget {
  const LessonCard(
      {super.key,
      required this.index,
      required this.lesson,
      required this.onPlayTap,
      required this.onLessonTap});
  final dynamic index;
  final LessonsPref lesson;
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: AutoSizeText(lesson.name ?? "No name",
                      maxLines: 2, style: style),
                ),
                SvgPicture.asset(content.selectedLesson[index]
                    ? ImagePath.arrowUpLesson
                    : ImagePath.arrowDownLesson),
              ],
            ),
            Container(
              padding: content.selectedLesson[index]
                  ? const EdgeInsets.symmetric(horizontal: 15, vertical: 5)
                  : EdgeInsets.zero,
              child: content.selectedLesson[index]
                  ? Column(
                      children: [
                        LessonPreview(
                          index: index,
                          lesson: lesson,
                          onTap: onPlayTap,
                        ),
                        const SizedBox(height: 15),
                        LessonPreview(
                          index: index,
                          lesson: lesson,
                          name: lesson.name ?? "lesson unavailable",
                          isPreview: false,
                          onTap: () {},
                        ),
                      ],
                    )
                  : null,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Divider(
                color: skipColor,
                thickness: 0.7,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LessonPreview extends StatelessWidget {
  const LessonPreview(
      {super.key,
      required this.index,
      required this.lesson,
      this.name = "Preview lesson",
      required this.onTap,
      this.isPreview = true});
  final dynamic index;
  final String name;
  final LessonsPref lesson;
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: AutoSizeText(
                name,
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
                    "${lesson.duration} minutes",
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
