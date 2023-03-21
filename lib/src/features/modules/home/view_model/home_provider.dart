import 'package:birds_learning_network/src/features/modules/courses/view/course_screen.dart';
import 'package:birds_learning_network/src/features/modules/home/model/repository/home_repository.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses_pref.dart';
import 'package:birds_learning_network/src/features/modules/user_cart/view/cart.dart';
import 'package:birds_learning_network/src/features/modules/home/view/home_page.dart';
import 'package:birds_learning_network/src/features/modules/profile/view/profile_page.dart';
import 'package:birds_learning_network/src/global_model/services/storage/shared_preferences/user_details.dart';
import 'package:flutter/material.dart';

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
    await prefCoursesGraph(context);
    await trendingCoursesGraph(context);
    await quickCoursesGraph(context);
  }

  // Home Screen Provider

  String _firstName = "There";
  List<CoursesPref> _searchResult = [];
  List<bool> selectedCards = [];
  List<String> courseList = [];
  Map<String, List<CoursesPref>> categories = {};
  final List<CoursesPref> _courses = [];
  List<CoursesPref> _quickCourses = [];
  List<CoursesPref> _prefCourses = [];
  List<CoursesPref> _trendingCourses = [];
  bool _onSearch = false;

  bool get onSearch => _onSearch;
  String get firstName => _firstName;
  List<CoursesPref> get searchResult => _searchResult;
  List<CoursesPref> get quickCourses => _quickCourses;
  List<CoursesPref> get trendingCourses => _trendingCourses;
  List<CoursesPref> get prefCourses => _prefCourses;

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

  void onSearchClicked(String text) {
    _searchResult = [];
    categories.forEach((key, value) {
      if (key == text) {
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

  // Future getAllCourses(context) async {
  //   try {
  //     GetCoursesModel response = await repo.getCompactCourse(context);
  //     if (response.responseCode == "00") {
  //       _courses = [];
  //       _quickCourses = [];
  //       _trendingCourses = [];
  //       _prefCourses = [];
  //       response.responseData!.toJson().forEach((key, value) {
  //         Categories category = Categories.fromJson(value);
  //         categories[key] = category.;
  //         _courses.addAll(category.categories![0].courses!);
  //         notifyListeners();
  //         if (key == "trendingCategories") {
  //           _trendingCourses.addAll(category.courses!);
  //           notifyListeners();
  //         } else if (key == "preferentialCategories") {
  //           _prefCourses.addAll(category.courses!);
  //           notifyListeners();
  //         } else if (key == "quickCategories") {
  //           _quickCourses.addAll(category.courses!);
  //           notifyListeners();
  //         }
  //       });
  //       print(categories);
  //       notifyListeners();
  //     } else {
  //       showSnack(context, response.responseCode!, response.responseMessage!);
  //     }
  //   } catch (_) {}
  // }

  Future prefCoursesGraph(context) async {
    try {
      _prefCourses = [];
      Map<String, List<CoursesPref>> response =
          await repo.getPreferenceCourses(context);
      // categories.addAll(response);
      response.forEach((key, value) {
        _prefCourses.addAll(value);
        if (categories.keys.contains(key)) {
          categories[key]!.addAll(value);
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
      Map<String, List<CoursesPref>> response =
          await repo.getQuickCourses(context);
      // categories.addAll(response);
      response.forEach((key, value) {
        _quickCourses.addAll(value);
        if (categories.keys.contains(key)) {
          categories[key]!.addAll(value);
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
      Map<String, List<CoursesPref>> response =
          await repo.getPreferenceCourses(context);
      // categories.addAll(response);
      response.forEach((key, value) {
        _trendingCourses.addAll(value);
        if (categories.keys.contains(key)) {
          categories[key]!.addAll(value);
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
