import 'dart:async';

import 'package:birds_learning_network/src/features/core/settings/view_model/filter_provider.dart';
import 'package:birds_learning_network/src/features/modules/courses/view/course_screen.dart';
import 'package:birds_learning_network/src/features/modules/home/model/repository/home_repository.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/features/modules/user_cart/view/cart.dart';
import 'package:birds_learning_network/src/features/modules/home/view/home_page.dart';
import 'package:birds_learning_network/src/features/modules/profile/view/profile_page.dart';
import 'package:birds_learning_network/src/global_model/services/storage/shared_preferences/user_details.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/response_snack.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeProvider extends ChangeNotifier {
  HomeRepository repo = HomeRepository();
  // General HomePage provider
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    UserHomePage(),
    CartPage(),
    MyCoursesPage(),
    UserProfilePage()
  ];

  List<Widget> get screens => _widgetOptions;
  int get selectedIndex => _selectedIndex;

  set onItemClick(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  //
  Future getHomeData(context) async {
    selectedCards = [];
    _onSearch = false;
    getUserData();
    await Provider.of<FilterProvider>(context, listen: false)
        .getPreferenceList(context);
    await prefCoursesGraph(context);
    await trendingCoursesGraph(context);
    await quickCoursesGraph(context);
    // getAllCourses(context);
  }

  Future refreshData(context) async {
    Future.delayed(const Duration(seconds: 75), () async {
      if (_prefCourses.isEmpty) {
        await prefCoursesGraph(context);
      }
      if (_trendingCourses.isEmpty) {
        await trendingCoursesGraph(context);
      }
      if (_quickCourses.isEmpty) {
        await quickCoursesGraph(context);
      }
      // if (_courses.isEmpty) {
      //     Future.delayed(const Duration(seconds: 30), () {
      //       getAllCourses(context);
      //     });
      //   }
    });
  }

  // Home Screen Provider

  String _firstName = "There";

  // the list for the courses searched
  List<Courses> _searchResult = [];

  // this list helps to note the selected preferences
  List<bool> selectedCards = [];

  // this list holdds the clicked trending icons
  List<bool> trendingIcons = [];

  // holds the clicked quick favorite icons
  List<bool> quickIcons = [];

  // holds the clicked top picks favorite icons
  List<bool> topIcons = [];
  List<Courses> availableCourses = [];

  List<String> courseList = [];
  Map<String, List<Courses>> categories = {};
  List<Courses> _courses = [];
  List<Courses> _quickCourses = [];
  List<Courses> _prefCourses = [];
  List<Courses> _trendingCourses = [];
  bool _onSearch = false;
  bool isCoursesLoading = false;

  bool get onSearch => _onSearch;
  String get firstName => _firstName;
  List<Courses> get searchResult => _searchResult;
  List<Courses> get quickCourses => _quickCourses;
  List<Courses> get courses => _courses;
  List<Courses> get trendingCourses => _trendingCourses;
  List<Courses> get prefCourses => _prefCourses;

  void getUserData() async {
    _firstName = await UserPreferences.getUserFirstName();
    notifyListeners();
  }

  void onSearchTriggered(bool value) {
    _onSearch = value;
    notifyListeners();
  }

  void setValue(index) {
    selectedCards[index] = !selectedCards[index];
    notifyListeners();
  }

  void setTopValue(index) {
    topIcons[index] = !topIcons[index];
    notifyListeners();
  }

  void setQuickValue(index) {
    quickIcons[index] = !quickIcons[index];
    notifyListeners();
  }

  void setTrendingValue(index) {
    trendingIcons[index] = !trendingIcons[index];
    notifyListeners();
  }

  void onSearchClicked(String text) {
    _searchResult = [];
    categories.forEach((key, value) {
      if (key.toLowerCase() == text.toLowerCase()) {
        _searchResult.addAll(value);
        notifyListeners();
      } else {
        for (var element in value) {
          if (element.title!.toLowerCase().startsWith(text.toLowerCase())) {
            _searchResult.add(element);
            notifyListeners();
          }
        }
      }
    });
    notifyListeners();
  }

  Future getAllCourses(context) async {
    try {
      isCoursesLoading = true;
      var response = await repo.getCompactCourse(context);
      if (response["responseCode"] == "00") {
        Map<String, dynamic> data = response['responseData'];
        _courses = [];
        for (var value in data.keys) {
          List categories_ = data[value];
          for (var element in categories_) {
            Category elem = Category.fromJson(element);
            _courses.addAll(elem.courses!);
          }
          notifyListeners();
        }
        isCoursesLoading = false;
        notifyListeners();
      } else {
        showSnack(context, response.responseCode!, response.responseMessage!);
      }
    } catch (_) {
      throw Exception(_);
    }
  }

  Future prefCoursesGraph(context) async {
    try {
      Map<String, List<Courses>> response =
          await repo.getPreferenceCourses(context);
      _prefCourses = [];
      response.forEach((key, value) {
        _prefCourses.addAll(value);
        if (categories.keys.contains(key)) {
          List<String> courseTitles = [];
          for (var course in categories[key]!) {
            courseTitles.add(course.title!);
          }
          for (var elem in value) {
            if (!courseTitles.contains(elem.title)) {
              categories[key]!.add(elem);
            }
          }
        } else {
          categories[key] = value;
        }
      });
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future quickCoursesGraph(context) async {
    try {
      _quickCourses = [];
      Map<String, List<Courses>> response = await repo.getQuickCourses(context);
      // categories.addAll(response);
      response.forEach((key, value) {
        _quickCourses.addAll(value);
        if (categories.keys.contains(key)) {
          List<String> courseTitles = [];
          for (var course in categories[key]!) {
            courseTitles.add(course.title!);
          }
          for (var elem in value) {
            if (!courseTitles.contains(elem.title)) {
              categories[key]!.add(elem);
            }
          }
        } else {
          categories[key] = value;
        }
      });
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }

  Future trendingCoursesGraph(context) async {
    try {
      _trendingCourses = [];
      Map<String, List<Courses>> response =
          await repo.getTrendingCourses(context);
      response.forEach((key, value) {
        _trendingCourses.addAll(value);
        if (categories.keys.contains(key)) {
          List<String> courseTitles = [];
          for (var course in categories[key]!) {
            courseTitles.add(course.title!);
          }
          for (var elem in value) {
            if (courseTitles.contains(elem.title) == false) {
              categories[key]!.add(elem);
            }
          }
        } else {
          categories[key] = value;
        }
      });
      notifyListeners();
    } catch (e) {
      throw Exception(e);
    }
  }
}
