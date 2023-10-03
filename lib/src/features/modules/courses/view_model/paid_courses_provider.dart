import 'package:birds_learning_network/src/features/modules/courses/model/repository/course_repository.dart';
import 'package:birds_learning_network/src/features/modules/courses/model/request/course_analysis.dart';
import 'package:birds_learning_network/src/features/modules/courses/model/request/save_review.dart';
import 'package:birds_learning_network/src/features/modules/courses/model/response/course_analysis.dart';
import 'package:birds_learning_network/src/features/modules/courses/model/response/db_course_model.dart';
import 'package:birds_learning_network/src/features/modules/courses/model/response/paid_courses.dart';
import 'package:birds_learning_network/src/features/modules/courses/model/response/save_review.dart';
import 'package:birds_learning_network/src/features/modules/courses/view/screens/assessment/assessment_tab.dart';
import 'package:birds_learning_network/src/features/modules/courses/view/screens/view_course/description_tab.dart';
import 'package:birds_learning_network/src/features/modules/courses/view/screens/view_course/lecture_tab.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/features/modules/user_cart/model/response_model/get_section.dart';
import 'package:birds_learning_network/src/global_model/apis/api_response.dart';
import 'package:birds_learning_network/src/utils/shared_functions/courses_functions/generate_db_sections.dart';
import 'package:birds_learning_network/src/utils/ui_utils/app_dialogs/success_dialog.dart';
import 'package:flutter/material.dart';

class PaidCoursesProvider extends ChangeNotifier {
  CourseRepository repo = CourseRepository();
  CourseModel? currentlyPlayingLesson;
  bool isLessonPlayed = false;  // this is to notify the UI that a lesson is being played
  Status loadingStatus = Status.initial;
  Status sectionStatus = Status.initial;
  Status reviewStatus = Status.initial;
  List<Courses> _courses = [];
  List<bool> selectedSection = [];
  int _selectedIndex = 0;
  List<List<CourseModel>> courseLessons = [];
  List<Sections> currentSections = [];
  int _lessonDuration = 0;
  int lessonProgress = 0;
  Courses? currentCourse;
  bool isRefreshing = false;

  List<Courses> get courses => _courses;

  int get selectedIndex => _selectedIndex;
  int get lessonDuration => _lessonDuration;

  void onTabClick(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void onRefreshStart(bool val){
    isRefreshing = val;
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

  void onPlayButtonClick(context, CourseModel lesson, String courseId) async{
    lessonProgress = 0;
    isLessonPlayed = true;
    notifyListeners();
   if(currentlyPlayingLesson != null && lessonProgress == 100){
     currentlyPlayingLesson!.lessonLastPlayedDuration = _lessonDuration;
     currentlyPlayingLesson!.progress = lessonProgress.toDouble();
     CourseAnalysisRequest body = getRequestData(currentlyPlayingLesson!, courseId);
     courseAnalysisMethod(context, body);
   }
    currentlyPlayingLesson = lesson;
    notifyListeners();
  }

  CourseAnalysisRequest getRequestData(CourseModel lesson, courseId, {int? perc}){
    return CourseAnalysisRequest(
      courseId: int.parse(courseId.toString()),
      lessonId: int.parse(lesson.lessonId ?? "0"),
      percentageOfLessonCompletion: perc ?? lesson.progress!.toInt()
    );
  }

  // this method is used to update the course to progress with the progress of the recently played lesson
  void onDisposed(context, String courseId) async {
    if(currentlyPlayingLesson != null){
      currentlyPlayingLesson!.lessonLastPlayedDuration = _lessonDuration;
      currentlyPlayingLesson!.progress = lessonProgress.toDouble();
      // String table  = await CourseSql.getTableName(courseId);
      // await CourseDatabase.instance.updateLessonProgress(table, currentlyPlayingLesson!);
      CourseAnalysisRequest body = getRequestData(currentlyPlayingLesson!, courseId);
      courseAnalysisMethod(context, body);

    }
  }

  void refreshValues() {
    selectedSection = [];
    courseLessons = [];
    currentSections = [];
    currentCourse = null;
    currentlyPlayingLesson = null;
    isLessonPlayed = false;
    notifyListeners();
  }

  // this method is used to get the recently played lesson progress (either 0 or 100)
  void getLessonProgress(dynamic sec, {bool isFinished = false}){
    _lessonDuration = int.parse(sec.toString());
    if(currentlyPlayingLesson != null && isFinished){
      lessonProgress = 100;
    }else{
      lessonProgress = 0;
    }
    notifyListeners();
  }

  // This method is used to handle the tab selection on the view-course screen
  Map<int, Widget> getTabWidget(Courses course,
      ValueChanged<CourseModel> updateController) {
    final Map<int, Widget> tabContent = {
      0: CourseDescriptionTab(course: course),
      1: LectureTabWidget(
        course: course,
        updateController: updateController,
      ),
      2: AssessmentTabWidget(
          course: course,
        updateController: updateController,
      ),
    };
    return tabContent;
  }

  // This method is used to get the sections that contains the course's lessons.
  Future getCourseSection(context, Courses course) async {
    try {
      setSectionStatus(status: Status.loading);
      // String tableName = await CourseSql.getTableName(course.id ?? "0");
      // await CourseDatabase.instance.createTable(tableName);
      GetCourseSection? response = await repo.getPickedSections(context, course.id ?? "0");
      if (response != null && response.responseCode == "00") {
        if(response.responseData != null && response.responseData!.isNotEmpty){
          course.sections = response.responseData;
          // await insertDatabaseCourse(course);
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

  // this method is called to update the database when a lesson is being watched
  Future courseAnalysisMethod(context, CourseAnalysisRequest body) async {
    try{
      CourseAnalysisResponse? response = await repo.postCourseAnalysis(context, body);
      if(response != null){
        if(response.responseCode == "00"){
          getCourseSection(context, Courses(id: body.courseId.toString()));
          getCourseByIdMethod(context, body.courseId.toString());
          return;
        }
      }
    }catch(e){
      return;
    }
  }

  void setReviewStatus({Status status = Status.initial}){
    reviewStatus = status;
    notifyListeners();
  }

  // This method will get the current course the user is watching so as to get the updated progress
  Future getCourseByIdMethod(context, String courseId)async{
    try{
      Courses? response = await repo.courseByIdRepo(context, courseId);
      if(response != null){
        currentCourse = response;
        notifyListeners();
      }
      return;
    }catch(e){
      return;
    }
  }
  
  Future saveReviewMethod(context, SaveReviewRequest body)async{
    try{
      setReviewStatus(status: Status.loading);
      SaveReviewResponse? response = await repo.saveReviewRepo(context, body);
      setReviewStatus(status: Status.completed);
      if(response != null){
        successDialog(context, response.responseMessage ?? "",
            "Your review has been successfully saved.\nWe appreciate your feedback.", "CLOSE", () {
          Navigator.pop(context);
            });
        return true;
      }
      return;
    }catch(e){
      setReviewStatus(status: Status.error);
      return;
    }
  }
}
