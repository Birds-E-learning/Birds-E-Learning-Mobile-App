import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/features/modules/user_cart/model/response_model/get_section.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_header.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_service.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_url.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/response_snack.dart';

class UnregisteredCourseRepo extends NetworkService with BaseHeaders, BaseUrl{

  Future getPickedSections(context, String id) async {
    Map<String, String> header_ = await anonymousHeader(context);
    var json =
    await getRequest("$getSection${int.parse(id)}", header_, context);
    GetCourseSection response = GetCourseSection.fromJson(json);
    return response;
  }

  Future getPreferenceCourses(context) async {
    Map<String, List<Courses>> categories = {};
    try {
      Map<String, String> header_ = await anonymousHeader(context);
      var json = await getRequest(getMiniCoursePref, header_, context, time: 100);
      GetCoursesResponse response = GetCoursesResponse.fromJson(json);
      var value = getCategories(response, categories, context);
      return value;
    } catch (e) {
      return null;
    }
  }

  Future getQuickCourses(context) async {
    Map<String, List<Courses>> categories = {};
    try {
      Map<String, String> header_ = await anonymousHeader(context);
      var json = await getRequest(getMiniCourseQuick, header_, context, time: 60);
      GetCoursesResponse response = GetCoursesResponse.fromJson(json);
      var value = getCategories(response, categories, context);
      return value;
    } catch (_) {
      return null;
    }
  }

  Future getTrendingCourses(context) async {
    Map<String, List<Courses>> categories = {};
    try {
      Map<String, String> header_ = await anonymousHeader(context);
      var json = await getRequest(getMiniCoursetrending, header_, context, time: 60);
      GetCoursesResponse response = GetCoursesResponse.fromJson(json);
      var value = getCategories(response, categories, context);
      return value;
    } catch (_) {
      return null;
    }
  }

  Future getCompactCourse(context) async {
    try {
      Map<String, String> header_ = await anonymousHeader(context);
      var json = await getRequest(allCourses, header_, context, time: 100);
      return json;
    } catch (e) {
      throw Exception(e);
    }
  }

  dynamic getCategories(GetCoursesResponse response, Map<String, List<Courses>> categories, context){
    if (response.responseCode == "00") {
      if (response.responseData!.categories!.isEmpty) {
        return null;
      }
      for (Category element in response.responseData!.categories!) {
        categories[element.name!] = element.courses!;
      }
      return categories;
    } else {
      showSnack(context, response.responseCode!, response.responseMessage!);
    }
  }
}