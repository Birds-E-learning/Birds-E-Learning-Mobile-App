import 'package:birds_learning_network/src/features/modules/courses/model/repository/course_repository.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/response_snack.dart';
import 'package:flutter/material.dart';

class CourseProvider extends ChangeNotifier {
  CourseRepository repo = CourseRepository();
  bool isLoading = false;
  List<Courses> _courses = [];
  Map<String, List<Courses>> categories = {};

  List<Courses> get allCourses => _courses;

  Future getAvailableCourses(context) async {
    try {
      _courses = [];
      isLoading = true;
      GetCoursesResponse response = await repo.getAllCourses(context);
      if (response.responseCode == "00") {
        for (Category elem in response.responseData!.categories!) {
          _courses.addAll(elem.courses!);
          categories[elem.name!] = elem.courses!;
        }
      } else {
        showSnack(context, response.responseCode!, response.responseMessage!);
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }

  void getCourses(context) async {
    if (_courses.isEmpty) {
      await getAvailableCourses(context);
    }
  }
}
