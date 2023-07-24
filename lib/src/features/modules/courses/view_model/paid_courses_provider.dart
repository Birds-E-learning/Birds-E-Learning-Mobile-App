import 'package:birds_learning_network/src/features/modules/courses/model/repository/course_repository.dart';
import 'package:birds_learning_network/src/features/modules/courses/model/response/paid_courses.dart';
import 'package:birds_learning_network/src/features/modules/courses/view/assessment/assessment_tab.dart';
import 'package:birds_learning_network/src/features/modules/courses/view/widgets/lecture_tab.dart';
import 'package:birds_learning_network/src/features/modules/courses/view/widgets/resource_tab.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:flutter/material.dart';

class PaidCoursesProvider extends ChangeNotifier {
  CourseRepository repo = CourseRepository();
  bool _isLoading = false;
  List<Courses> _courses = [];
  List<bool> selectedSection = [];
  double lecturePosition = 0;
  double resourcePosition = 0;
  double assessPosition = 0;
  int _selectedIndex = 0;

  bool get isLoading => _isLoading;
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

  Future getPaidCoursesMethod(context) async {
    try {
      _isLoading = true;
      var json = await repo.getPaidCourses(context);
      if (json != null) {
        PaidCoursesResponse response = PaidCoursesResponse.fromJson(json);
        if (response.responseCode == "00") {
          _courses = response.responseData!;
          notifyListeners();
        }
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Map<int, Widget> getTabWidget(
    Courses course,
  ) {
    final Map<int, Widget> tabContent = {
      0: LectureTabWidget(
        course: course,
      ),
      1: const ResourcesTabWidget(),
      2: AssessmentTabWidget(course: course),
    };
    return tabContent;
  }
}
