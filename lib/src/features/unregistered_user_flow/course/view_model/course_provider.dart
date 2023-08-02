import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/features/modules/user_cart/model/response_model/get_section.dart';
import 'package:birds_learning_network/src/features/unregistered_user_flow/course/model/repository/course_repo.dart';
import 'package:birds_learning_network/src/global_model/apis/api_response.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/response_snack.dart';
import 'package:flutter/cupertino.dart';

class UnregisteredCourseProvider extends UnregisteredCourseRepo with ChangeNotifier{
  final String _firstName = "There";

  // the list for the courses searched
  List<Courses> _searchResult = [];

  // this list helps to note the selected preferences
  List<bool> selectedCards = [];

  Map<String, List<Courses>> categories = {};
  // final List<Courses> _courses = [];
  // List of courses for each category
  List<Courses> _quickCourses = [];
  List<Courses> _prefCourses = [];
  List<Courses> _trendingCourses = [];
  bool _onSearch = false;
  bool isCoursesLoading = false;

  // loading booleans
  Status prefStatus = Status.initial;
  Status trendingStatus = Status.initial;
  Status quickStatus = Status.initial;

  bool get onSearch => _onSearch;
  String get firstName => _firstName;
  List<Courses> get searchResult => _searchResult;
  List<Courses> get quickCourses => _quickCourses;
  // List<Courses> get courses => _courses;
  List<Courses> get trendingCourses => _trendingCourses;
  List<Courses> get prefCourses => _prefCourses;

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

  Future<void> refreshData(context, {bool reload = true}) async {
    if (reload) {
      Future.delayed(const Duration(seconds: 75), () async {
        if (_prefCourses.isEmpty && prefStatus != Status.completed) {
          prefCoursesGraph(context);
        }
        if (_trendingCourses.isEmpty && trendingStatus != Status.completed) {
          trendingCoursesGraph(context);
        }
        if (_quickCourses.isEmpty && quickStatus != Status.completed) {
          quickCoursesGraph(context);
        }
      });
    } else {
      prefCoursesGraph(context);
      trendingCoursesGraph(context);
      quickCoursesGraph(context);
    }
  }

  Future prefCoursesGraph(context) async {
    try {
      prefStatus = Status.loading;
      notifyListeners();
      Map<String, List<Courses>>? response = await getPreferenceCourses(context);
      if(response!= null){
        _prefCourses = extractCoursesFunc(response);
      }
      prefStatus = Status.completed;
      notifyListeners();
      return;
    } catch (e) {
      prefStatus = Status.error;
      notifyListeners();
      throw Exception(e);
    }
  }

  Future trendingCoursesGraph(context) async {
    try {
      trendingStatus = Status.loading;
      notifyListeners();
      Map<String, List<Courses>>? response = await getTrendingCourses(context);
      if(response!= null){
        _trendingCourses = extractCoursesFunc(response);
      }
      trendingStatus = Status.completed;
      notifyListeners();
      return;
    } catch (e) {
      trendingStatus = Status.error;
      notifyListeners();
      throw Exception(e);
    }
  }

  Future quickCoursesGraph(context) async {
    try {
      quickStatus = Status.loading;
      notifyListeners();
      Map<String, List<Courses>>? response = await getQuickCourses(context);
      if(response!= null){
        _quickCourses = extractCoursesFunc(response);
      }
      quickStatus = Status.completed;
      notifyListeners();
      return;
    } catch (e) {
      quickStatus = Status.error;
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

  Future getCourseSection(context, String id) async {
    try {
      GetCourseSection response = await getPickedSections(context, id);
      if (response.responseCode == "00") {
        return response.responseData;
      } else {
        showSnack(context, response.responseCode!, response.responseMessage!);
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}