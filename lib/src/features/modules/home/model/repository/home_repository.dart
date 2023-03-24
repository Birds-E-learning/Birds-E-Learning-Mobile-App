import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_all_courses.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses_pref.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_header.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_service.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_url.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/response_snack.dart';

class HomeRepository extends NetworkService with BaseUrl, BaseHeaders {
  Future getPreferenceCourses(context) async {
    Map<String, List<CoursesPref>> categories = {};
    // List<CoursesPref> prefCourses = [];
    // try {
    Map<String, String> header_ = await authHeader();
    var json = await getRequest(getCoursePref, header_, context);
    GetCourseCategory response = GetCourseCategory.fromJson(json);
    if (response.responseCode == "00") {
      for (Categories element in response.responseData!.categories!) {
        categories[element.name!] = element.courses!;
        // prefCourses.addAll(element.courses!);
      }
      return categories;
    } else {
      showSnack(context, response.responseCode!, response.responseMessage!);
    }
    // } catch (_) {
    //   showSnack(context, "02", "Unable to load Courses");
    // }
  }

  Future getQuickCourses(context) async {
    Map<String, List<CoursesPref>> categories = {};
    // List<CoursesPref> quickCourses = [];
    // try {
    Map<String, String> header_ = await authHeader();
    var json = await getRequest(getCourseQuick, header_, context);
    GetCourseCategory response = GetCourseCategory.fromJson(json);
    if (response.responseCode == "00") {
      for (var element in response.responseData!.categories!) {
        categories[element.name!] = element.courses!;
        // quickCourses.addAll(element.courses!);
      }
      return categories;
    } else {
      showSnack(context, response.responseCode!, response.responseMessage!);
    }
    // } catch (_) {
    //   showSnack(context, "02", "Unable to load Courses");
    // }
  }

  Future getTrendingCourses(context) async {
    Map<String, List<CoursesPref>> categories = {};
    // List<CoursesPref> trendingCourses = [];
    try {
      Map<String, String> header_ = await authHeader();
      var json = await getRequest(getCoursetrending, header_, context);
      GetCourseCategory response = GetCourseCategory.fromJson(json);
      if (response.responseCode == "00") {
        for (Categories element in response.responseData!.categories!) {
          categories[element.name!] = element.courses!;
          // trendingCourses.addAll(element.courses!);
        }
        return categories;
      } else {
        showSnack(context, response.responseCode!, response.responseMessage!);
      }
    } catch (_) {
      showSnack(context, "02", "Unable to load Courses");
    }
  }

  Future getCompactCourse(context) async {
    Map<String, String> header_ = await authHeader();
    var json = await getRequest(allCourses, header_, context);
    GetCoursesModel response = GetCoursesModel.fromJson(json);
    return response;
  }
}