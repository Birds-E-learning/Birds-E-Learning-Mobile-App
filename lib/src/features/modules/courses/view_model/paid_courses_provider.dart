import 'package:birds_learning_network/src/features/modules/courses/model/repository/course_database.dart';
import 'package:birds_learning_network/src/features/modules/courses/model/repository/course_repository.dart';
import 'package:birds_learning_network/src/features/modules/courses/model/request/course_analysis.dart';
import 'package:birds_learning_network/src/features/modules/courses/model/response/course_analysis.dart';
import 'package:birds_learning_network/src/features/modules/courses/model/response/db_course_model.dart';
import 'package:birds_learning_network/src/features/modules/courses/model/response/paid_courses.dart';
import 'package:birds_learning_network/src/features/modules/courses/view/screens/assessment/assessment_tab.dart';
import 'package:birds_learning_network/src/features/modules/courses/view/screens/view_course/lecture_tab.dart';
import 'package:birds_learning_network/src/features/modules/courses/view/widgets/resource_tab.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/features/modules/user_cart/model/response_model/get_section.dart';
import 'package:birds_learning_network/src/global_model/apis/api_response.dart';
import 'package:birds_learning_network/src/utils/global_constants/database/course_sql.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/response_snack.dart';
import 'package:birds_learning_network/src/utils/shared_functions/courses_functions/generate_db_sections.dart';
import 'package:birds_learning_network/src/utils/shared_functions/courses_functions/insert_db_lesson.dart';
import 'package:flutter/material.dart';

class PaidCoursesProvider extends ChangeNotifier {
  CourseRepository repo = CourseRepository();
  CourseModel? currentlyPlayingLesson;
  bool isLessonPlayed = false;
  Status loadingStatus = Status.initial;
  Status sectionStatus = Status.initial;
  Status analysisStatus = Status.initial;
  List<Courses> _courses = [];
  List<bool> selectedSection = [];
  int _selectedIndex = 0;
  List<List<CourseModel>> courseLessons = [];
  List<Sections> currentSections = [];
  int _lessonDuration = 0;
  int lessonProgress = 0;

  List<Courses> get courses => _courses;

  int get selectedIndex => _selectedIndex;
  int get lessonDuration => _lessonDuration;

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

  void onPlayButtonClick(context, CourseModel lesson,String courseId) async{
    isLessonPlayed = true;
   if(currentlyPlayingLesson != null){
     currentlyPlayingLesson!.lessonLastPlayedDuration = _lessonDuration;
     currentlyPlayingLesson!.progress = lessonProgress.toDouble();
     String table  = await CourseSql.getTableName(courseId);
     await CourseDatabase.instance.updateLessonProgress(table, currentlyPlayingLesson!);
     CourseAnalysisRequest body = getRequestData(currentlyPlayingLesson!, courseId);
     await courseAnalysisMethod(context, body);
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

  void onDisposed(context, String courseId) async {
    if(currentlyPlayingLesson != null){
      // print("lesson duration ==>> $_lessonDuration and lesson progress ====>>> $lessonProgress");
      currentlyPlayingLesson!.lessonLastPlayedDuration = _lessonDuration;
      currentlyPlayingLesson!.progress = lessonProgress.toDouble();
      String table  = await CourseSql.getTableName(courseId);
      await CourseDatabase.instance.updateLessonProgress(table, currentlyPlayingLesson!);
      CourseAnalysisRequest body = getRequestData(currentlyPlayingLesson!, courseId);
      await courseAnalysisMethod(context, body);
    }
  }

  void refreshValues() {
    selectedSection = [];
    currentlyPlayingLesson = null;
    isLessonPlayed = false;
    notifyListeners();
  }

  void getLessonProgress(dynamic sec, {bool isFinished = false}){
    _lessonDuration = int.parse(sec.toString());
    print("seconds =====>>>>> $sec");
    // int durationMin = sec ~/ 60;
    if(currentlyPlayingLesson != null && isFinished){
      lessonProgress = 100;
      print("here ====>>>>> to update lesson's progress");
    }else{
      lessonProgress = 0;
    }
    notifyListeners();
  }

  Map<int, Widget> getTabWidget(Courses course,
      ValueChanged<CourseModel> updateController) {
    final Map<int, Widget> tabContent = {
      0: LectureTabWidget(
        course: course,
        updateController: updateController,
      ),
      1: const ResourcesTabWidget(),
      2: AssessmentTabWidget(
          course: course,
        updateController: updateController,
      ),
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

  Future courseAnalysisMethod(context, CourseAnalysisRequest body) async {
    try{
      setAnalysisStatus(status: Status.loading);
      CourseAnalysisResponse? response = await repo.postCourseAnalysis(context, body);
      if(response != null){
        print(response.toJson());
        if(response.responseCode == "00"){
          print(body.toJson());
          showSnack(context, response.responseCode!, response.responseMessage ?? "");
          setAnalysisStatus(status: Status.completed);
          return;
        }
      }
      setAnalysisStatus(status: Status.error);
    }catch(e){
      setAnalysisStatus(status: Status.error);
    }
  }

  void setAnalysisStatus({Status status = Status.initial}){
    analysisStatus = status;
    notifyListeners();
  }
}
