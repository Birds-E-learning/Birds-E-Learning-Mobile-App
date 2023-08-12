// import 'package:birds_learning_network/src/features/modules/courses/model/repository/course_repository.dart';
// import 'package:birds_learning_network/src/features/modules/courses/model/response/paid_courses.dart';
// import 'package:birds_learning_network/src/features/modules/courses/view/screens/assessment/assessment_tab.dart';
// import 'package:birds_learning_network/src/features/modules/courses/view/screens/view_course/lecture_tab.dart';
// import 'package:birds_learning_network/src/features/modules/courses/view/widgets/resource_tab.dart';
// import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
// import 'package:birds_learning_network/src/global_model/apis/api_response.dart';
// import 'package:flutter/material.dart';
// import 'package:pod_player/pod_player.dart';
//
// class PaidCoursesProvider extends ChangeNotifier {
//   CourseRepository repo = CourseRepository();
//   String currentlyPlayingVideo = "";
//   late final PodPlayerController controller;
//   bool isLessonPlayed = false;
//   Status loadingStatus = Status.initial;
//   final bool _isPrivate = false;
//   List<Courses> _courses = [];
//   List<bool> selectedSection = [];
//   int _selectedIndex = 0;
//
//   List<Courses> get courses => _courses;
//   int get selectedIndex => _selectedIndex;
//
//   void onTabClick(int index) {
//     _selectedIndex = index;
//     notifyListeners();
//   }
//
//   void setSelectedSection(int index) {
//     selectedSection[index] = !selectedSection[index];
//     notifyListeners();
//   }
//
//   void setLoadingStatus({Status status = Status.initial}){
//     loadingStatus = status;
//     notifyListeners();
//   }
//
//   Future getPaidCoursesMethod(context) async {
//     try {
//       setLoadingStatus(status: Status.loading);
//       var json = await repo.getPaidCourses(context);
//       if (json != null) {
//         PaidCoursesResponse response = PaidCoursesResponse.fromJson(json);
//         if (response.responseCode == "00") {
//           _courses = response.responseData!;
//           notifyListeners();
//         }
//       }
//       setLoadingStatus(status: Status.completed);
//     } catch (e) {
//       setLoadingStatus(status: Status.error);
//     }
//   }
//
//   void onPlayButtonClick(String vidUrl) {
//     isLessonPlayed = true;
//     currentlyPlayingVideo = vidUrl;
//     notifyListeners();
//   }
//
//   void refreshValues({isInit = false}) {
//     currentlyPlayingVideo = "";
//     isLessonPlayed = false;
//     isInit ? null : notifyListeners();
//   }
//
//   Map<int, Widget> getTabWidget(
//       Courses course, ValueChanged<String> updateController) {
//     final Map<int, Widget> tabContent = {
//       0: LectureTabWidget(
//         course: course,
//         updateController: updateController,
//       ),
//       1: const ResourcesTabWidget(),
//       2: AssessmentTabWidget(course: course),
//     };
//     return tabContent;
//   }
//
//   void updatePodController() {
//     if (currentlyPlayingVideo.isNotEmpty) {
//       controller = PodPlayerController(
//         playVideoFrom: podPlayerService(),
//         podPlayerConfig: const PodPlayerConfig(
//             autoPlay: true, isLooping: false, videoQualityPriority: [720, 360]),
//       )..initialise();
//     }
//   }
//
//   PlayVideoFrom podPlayerService() {
//     if (currentlyPlayingVideo.toLowerCase().contains("youtu") ||
//         currentlyPlayingVideo.toLowerCase().contains("youtube.com")) {
//       return youtubePlayer(currentlyPlayingVideo);
//     } else if (currentlyPlayingVideo.toLowerCase().contains("vimeo")) {
//       return vimeoPlayer(currentlyPlayingVideo, _isPrivate);
//     } else {
//       return videoPlayer(currentlyPlayingVideo);
//     }
//   }
//
//   PlayVideoFrom youtubePlayer(String vidUrl) {
//     List vidId =
//     vidUrl.contains("?v=") ? vidUrl.split("?v=") : vidUrl.split("/");
//     return PlayVideoFrom.youtube(vidId[vidId.length - 1],
//         videoPlayerOptions: VideoPlayerOptions());
//   }
//
//   PlayVideoFrom vimeoPlayer(String vidUrl, bool isPrivate) {
//     String vimeoId = extractVimeoId(vidUrl);
//     if (isPrivate) {
//       final Map<String, String> headers = <String, String>{'Authorization': ''};
//       return PlayVideoFrom.vimeoPrivateVideos(vimeoId, httpHeaders: headers);
//     } else {
//       return PlayVideoFrom.vimeo(vimeoId);
//     }
//   }
//
//   PlayVideoFrom videoPlayer(String vidUrl) {
//     return PlayVideoFrom.network(vidUrl);
//   }
//
//   extractVimeoId(String videoUrl) {
//     RegExp regExp =
//     RegExp(r'vimeo\.com/(\d+)|player\.vimeo\.com/video/(\w+)');
//     Match? match1 = regExp.firstMatch(videoUrl);
//     if (match1 != null) {
//       String vimeoId1 = match1.group(1) ?? match1.group(2)!;
//       return vimeoId1;
//     } else {
//       return "";
//     }
//   }
//
//   @override
//   void dispose() {
//     controller.isInitialised ? controller.dispose : null;
//     super.dispose();
//   }
// }
