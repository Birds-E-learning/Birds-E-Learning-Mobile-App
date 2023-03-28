import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_header.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_service.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_url.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/response_snack.dart';

class HomeRepository extends NetworkService with BaseUrl, BaseHeaders {
  Future getPreferenceCourses(context) async {
    Map<String, List<Courses>> categories = {};
    // List<CoursesPref> prefCourses = [];
    try {
      Map<String, String> header_ = await authHeader();
      var json = await getRequest(getCoursePref, header_, context, time: 100);
      GetCoursesResponse response = GetCoursesResponse.fromJson(json);
      // GetCourseCategory response = GetCourseCategory.fromJson(json);
      if (response.responseCode == "00") {
        if (response.responseData!.categories!.isEmpty) {
          return "no data";
        }
        for (Category element in response.responseData!.categories!) {
          categories[element.name!] = element.courses!;
        }
        return categories;
      } else {
        showSnack(context, response.responseCode!, response.responseMessage!);
      }
    } catch (e) {
      showSnack(context, "02", "Unable to load Preference Courses");
    }
  }

  Future getQuickCourses(context) async {
    Map<String, List<Courses>> categories = {};
    // List<CoursesPref> quickCourses = [];
    try {
      Map<String, String> header_ = await authHeader();
      var json = await getRequest(getCourseQuick, header_, context, time: 60);
      GetCoursesResponse response = GetCoursesResponse.fromJson(json);
      if (response.responseCode == "00") {
        if (response.responseData!.categories!.isEmpty) {
          return "no data";
        }
        for (Category element in response.responseData!.categories!) {
          categories[element.name!] = element.courses!;
        }
        return categories;
      } else {
        showSnack(context, response.responseCode!, response.responseMessage!);
      }
    } catch (_) {
      showSnack(context, "02", "Unable to load Quick Courses");
    }
  }

  Future getTrendingCourses(context) async {
    Map<String, List<Courses>> categories = {};
    try {
      Map<String, String> header_ = await authHeader();
      var json =
          await getRequest(getCoursetrending, header_, context, time: 60);
      GetCoursesResponse response = GetCoursesResponse.fromJson(json);
      if (response.responseCode == "00") {
        print(response.responseCode);
        if (response.responseData!.categories!.isEmpty) {
          return "no data";
        }
        for (Category element in response.responseData!.categories!) {
          print("here first=====>> $element");
          categories[element.name!] = element.courses!;
          print("image url -====.>>> ${element.courses![0].imageUrl}");
        }
        return categories;
      } else {
        print(response.responseCode);
        showSnack(context, response.responseCode!, response.responseMessage!);
      }
    } catch (_) {
      showSnack(context, "02", "Unable to load trending Courses");
    }
  }

  Future getCompactCourse(context) async {
    try {
      Map<String, String> header_ = await authHeader();
      var json = await getRequest(allCourses, header_, context, time: 100);
      print(json);
      return json;
    } catch (e) {
      print(e);
    }
  }
}
