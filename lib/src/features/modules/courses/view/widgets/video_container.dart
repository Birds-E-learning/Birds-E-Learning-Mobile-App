import 'package:birds_learning_network/src/features/modules/courses/model/request/course_analysis.dart';
import 'package:birds_learning_network/src/features/modules/courses/view_model/paid_courses_provider.dart';
import 'package:birds_learning_network/src/utils/global_constants/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerContainer extends StatelessWidget {
  const VideoPlayerContainer({super.key, required this.controller, required this.courseId});
  final YoutubePlayerController controller;
  final String courseId;

  @override
  Widget build(BuildContext context) {
    return Consumer<PaidCoursesProvider>(
      builder: (_, course, __) => Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: borderColor),
            borderRadius: BorderRadius.circular(20)),
        child: YoutubePlayerBuilder(
          // key: ,
          player: YoutubePlayer(
              controller: controller,
            showVideoProgressIndicator: true,
            progressIndicatorColor: greys200,
            progressColors: const ProgressBarColors(
              playedColor: skipColor,
              handleColor: success900,
            ),
            onEnded: (value)async{
                // print("course lesson duration ====>> ${value.duration}");
                if(value.duration.inSeconds == 0)return;
              course.getLessonProgress(controller.value.position.inSeconds, isFinished: true);
              CourseAnalysisRequest body = course.getRequestData(course.currentlyPlayingLesson!, courseId, perc: 100);
              await course.courseAnalysisMethod(context, body);
            },
            onReady: (){
                controller.addListener(() {
                  if(controller.value.position.inSeconds != course.lessonDuration){
                    course.getLessonProgress(controller.value.position.inSeconds);
                  }
                });
            },
          ),
          builder: (_,player) => player,
        ),
      ),
    );
  }
}
