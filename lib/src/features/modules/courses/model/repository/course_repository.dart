import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_header.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_service.dart';
import 'package:birds_learning_network/src/global_model/services/network/base_url.dart';
import 'package:birds_learning_network/src/utils/helper_widgets/response_snack.dart';

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
}
