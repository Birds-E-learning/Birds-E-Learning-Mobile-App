import 'package:birds_learning_network/src/features/modules/courses/model/response/courses_all_response.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/features/modules/user_cart/model/response_model/get_section.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_header.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_service.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_url.dart';

class CourseRepository extends NetworkService with BaseUrl, BaseHeaders {
  Future getAllCourses(context) async {
    // List<ResponseData>
    try {
      Map<String, String> header_ = await authHeader();
      var json = await getRequest(getCourses, header_, context, time: 100);
      GetCoursesResponse response = GetCoursesResponse.fromJson(json);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future getAvailableCourses(context) async {
    try {
      Map<String, String> header_ = await authHeader();
      var json = await getRequest(availableCourses, header_, context);
      GetCoursesAllResponse response = GetCoursesAllResponse.fromJson(json);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future getPaidCourses(context) async {
    try {
      Map<String, String> header_ = await authHeader();
      var json = await getRequest(coursePaid, header_, context);
      return json;
    } catch (e) {
      return null;
    }
  }

  Future getPickedSections(context, String id) async {
    Map<String, String> header_ = await authHeader();
    var json =
    await getRequest("$getSection${int.parse(id)}", header_, context);
    GetCourseSection response = GetCourseSection.fromJson(json);
    return response;
  }
}
