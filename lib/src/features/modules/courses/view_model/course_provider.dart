import 'package:birds_learning_network/src/features/modules/courses/model/repository/course_repository.dart';
import 'package:birds_learning_network/src/features/modules/courses/model/response/courses_all_response.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/response_snack.dart';
import 'package:flutter/material.dart';

class CourseProvider extends ChangeNotifier {
  CourseRepository repo = CourseRepository();
  bool isLoading = false;
  List<Courses> _courses = [];
  List<Courses> _allCourses = [];
  Map<String, List<Courses>> categories = {};

  List<Courses> get allCourses => _courses;
  List<Courses> get courses => _allCourses;

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
    if (_allCourses.isEmpty && !isLoading) {
      await getCoursesAll(context);
    }
  }

  Future getCoursesAll(context) async {
    try {
      isLoading = true;
      GetCoursesAllResponse response = await repo.getAvailableCourses(context);
      if (response.responseCode == "00") {
        _allCourses = response.responseData!.courses!;
        notifyListeners();
      } else {
        showSnack(context, response.responseCode!, response.responseMessage!);
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }
}
