import 'package:birds_learning_network/src/features/modules/courses/model/repository/course_database.dart';
import 'package:birds_learning_network/src/features/modules/courses/model/repository/course_repository.dart';
import 'package:birds_learning_network/src/features/modules/courses/model/response/db_course_model.dart';
import 'package:birds_learning_network/src/features/modules/courses/model/response/paid_courses.dart';
import 'package:birds_learning_network/src/features/modules/courses/view/screens/assessment/assessment_tab.dart';
import 'package:birds_learning_network/src/features/modules/courses/view/screens/view_course/lecture_tab.dart';
import 'package:birds_learning_network/src/features/modules/courses/view/widgets/resource_tab.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/features/modules/user_cart/model/response_model/get_section.dart';
import 'package:birds_learning_network/src/global_model/apis/api_response.dart';
import 'package:birds_learning_network/src/utils/global_constants/database/course_sql.dart';
import 'package:birds_learning_network/src/utils/shared_functions/courses_functions/generate_db_sections.dart';
import 'package:birds_learning_network/src/utils/shared_functions/courses_functions/insert_db_lesson.dart';
import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';

class PaidCoursesProvider extends ChangeNotifier {
  CourseRepository repo = CourseRepository();
  String currentlyPlayingVideo = "";
  bool isLessonPlayed = false;
  Status loadingStatus = Status.initial;
  Status sectionStatus = Status.initial;
  List<Courses> _courses = [];
  List<bool> selectedSection = [];
  int _selectedIndex = 0;
  List<List<CourseModel>> courseLessons = [];
  List<Sections> currentSections = [];

  List<Courses> get courses => _courses;

  int get selectedIndex => _selectedIndex;

  void onTabClick(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void setSelectedSection(int index) {
    selectedSection[index] = !selectedSection[index];
    notifyListeners();
  }

  void setLoadingStatus({Status status = Status.initial}) {
    loadingStatus = status;
    notifyListeners();
  }

  void setSectionStatus({Status status = Status.initial}) {
    sectionStatus = status;
    notifyListeners();
  }

  Future getPaidCoursesMethod(context) async {
    try {
      setLoadingStatus(status: Status.loading);
      var json = await repo.getPaidCourses(context);
      if (json != null) {
        PaidCoursesResponse response = PaidCoursesResponse.fromJson(json);
        if (response.responseCode == "00") {
          _courses = response.responseData!;
          notifyListeners();
        }
      }
      setLoadingStatus(status: Status.completed);
    } catch (e) {
      setLoadingStatus(status: Status.error);
    }
  }

  void onPlayButtonClick(String vidUrl) {
    isLessonPlayed = true;
    currentlyPlayingVideo = vidUrl;
    notifyListeners();
  }

  void refreshValues() {
    selectedSection = [];
    currentlyPlayingVideo = "";
    isLessonPlayed = false;
    notifyListeners();
  }

  Map<int, Widget> getTabWidget(Courses course,
      ValueChanged<String> updateController) {
    final Map<int, Widget> tabContent = {
      0: LectureTabWidget(
        course: course,
        updateController: updateController,
      ),
      1: const ResourcesTabWidget(),
      2: AssessmentTabWidget(course: course),
    };
    return tabContent;
  }

  Future getCourseSection(context, Courses course) async {
    try {
      courseLessons = [];
      currentSections = [];
      notifyListeners();
      setSectionStatus(status: Status.loading);
      String tableName = await CourseSql.getTableName(course.id ?? "0");
      await CourseDatabase.instance.createTable(tableName);
      GetCourseSection? response = await repo.getPickedSections(context, course.id ?? "0");
      if (response != null && response.responseCode == "00") {
        if(response.responseData != null && response.responseData!.isNotEmpty){
          course.sections = response.responseData;
          await insertDatabaseCourse(course);
          var sectionData = await getSectionLessons(course.id ?? "0", response.responseData!);
          courseLessons = sectionData;
          currentSections = response.responseData ?? [];
          notifyListeners();
        }
      }
      setSectionStatus(status: Status.completed);
    } catch (e) {
      setSectionStatus(status: Status.error);
      debugPrint(e.toString());
    }
  }

  PlayVideoFrom youtubePlayer(String vidUrl) {
    List vidId =
    vidUrl.contains("?v=") ? vidUrl.split("?v=") : vidUrl.split("/");
    return PlayVideoFrom.youtube(vidId[vidId.length - 1],
        videoPlayerOptions: VideoPlayerOptions());
  }
}
