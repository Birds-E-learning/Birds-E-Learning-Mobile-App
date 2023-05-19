import 'dart:convert';

import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoursePreference {
  static Future getCourseById(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var course = prefs.getString("course$id");
    debugPrint("course====>>> $course");
    return course == null ? course : jsonDecode(course);
  }

  static Future<bool> saveCourseById(Courses course) async {
    final course_ = json.encode(course.toJson());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString("course${course.id}", course_);
  }
}
