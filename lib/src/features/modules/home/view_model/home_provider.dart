import 'dart:async';

import 'package:birds_learning_network/src/features/core/settings/view_model/filter_provider.dart';
import 'package:birds_learning_network/src/features/modules/courses/view/screens/course_screen.dart';
import 'package:birds_learning_network/src/features/modules/home/model/repository/home_repository.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/features/modules/user_cart/view/cart.dart';
import 'package:birds_learning_network/src/features/modules/home/view/screens/home_page.dart';
import 'package:birds_learning_network/src/features/modules/profile/view/profile_page.dart';
import 'package:birds_learning_network/src/global_model/services/storage/shared_preferences/user_details.dart';
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
    Provider.of<FilterProvider>(context, listen: false)
        .getPreferenceList(context);
    prefCoursesGraph(context);
    trendingCoursesGraph(context);
    quickCoursesGraph(context);
    // getAllCourses(context);
  }

  Future<void> refreshData(context, {bool reload = true}) async {
    if (reload) {
      Future.delayed(const Duration(seconds: 75), () async {
        if (_prefCourses.isEmpty) {
          prefCoursesGraph(context);
        }
        if (_trendingCourses.isEmpty) {
          trendingCoursesGraph(context);
        }
        if (_quickCourses.isEmpty) {
          quickCoursesGraph(context);
        }
      });
    } else {
      prefCoursesGraph(context);
      trendingCoursesGraph(context);
      quickCoursesGraph(context);
    }
  }

  // Home Screen Provider

  String _firstName = "There";

  // the list for the courses searched
  List<Courses> _searchResult = [];

  // this list helps to note the selected preferences
  List<bool> selectedCards = [];

  // this list holds the clicked trending icons
  List<bool> trendingIcons = [];

  // holds the clicked quick favorite icons
  List<bool> quickIcons = [];

  // holds the clicked top picks favorite icons
  List<bool> topIcons = [];
  List<Courses> availableCourses = [];

  List<String> courseList = [];
  Map<String, List<Courses>> categories = {};
  final List<Courses> _courses = [];
  List<Courses> _quickCourses = [];
  List<Courses> _prefCourses = [];
  List<Courses> _trendingCourses = [];
  bool _onSearch = false;
  bool isCoursesLoading = false;

  // loading booleans
  bool isPrefLoading = false;
  bool isTrendingLoading = false;
  bool isQuickLoading = false;

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
          if (element.title!.toLowerCase().contains(text.toLowerCase())) {
            _searchResult.add(element);
            notifyListeners();
          }
        }
      }
    });
    notifyListeners();
  }

  Future prefCoursesGraph(context) async {
    try {
      topIcons = [];
      isPrefLoading = true;
      Map<String, List<Courses>>? response =
          await repo.getPreferenceCourses(context);
      if(response != null){
        _prefCourses = extractCoursesFunc(response);
      }
      isPrefLoading = false;
      notifyListeners();
    } catch (e) {
      isPrefLoading = false;
      throw Exception(e);
    }
  }

  Future quickCoursesGraph(context) async {
    try {
      quickIcons = [];
      isQuickLoading = true;
      Map<String, List<Courses>>? response = await repo.getQuickCourses(context);
      if(response != null){
        _quickCourses = extractCoursesFunc(response);
      }
      isQuickLoading = false;
      notifyListeners();
    } catch (e) {
      isQuickLoading = false;
      throw Exception(e);
    }
  }

  Future trendingCoursesGraph(context) async {
    try {
      trendingIcons = [];
      isTrendingLoading = true;
      notifyListeners();
      Map<String, List<Courses>>? response =
          await repo.getTrendingCourses(context);
      if(response != null){
        _trendingCourses = extractCoursesFunc(response);
      }
      isTrendingLoading = false;
      notifyListeners();
    } catch (e) {
      isTrendingLoading = false;
      notifyListeners();
      throw Exception(e);
    }
  }

  List<Courses> extractCoursesFunc(Map<String, List<Courses>> response){
    List<Courses> categoryCourses = [];
    response.forEach((key, value) {
      categoryCourses.addAll(value);
      if (categories.keys.contains(key)) {
        List<String> courseTitles = []; // This function holds the course titles in the category to avoid repetitions.
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
    return categoryCourses;
  }

}
