import 'package:birds_learning_network/src/features/modules/courses/model/request/course_analysis.dart';
import 'package:birds_learning_network/src/features/modules/courses/model/request/save_review.dart';
import 'package:birds_learning_network/src/features/modules/courses/model/response/course_analysis.dart';
import 'package:birds_learning_network/src/features/modules/courses/model/response/courses_all_response.dart';
import 'package:birds_learning_network/src/features/modules/courses/model/response/save_review.dart';
import 'package:birds_learning_network/src/features/modules/courses/model/response/single_course.dart';
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
    try{
      Map<String, String> header_ = await authHeader();
      var json = await getRequest("$getSection${int.parse(id)}", header_, context);
      if(json != null){
        GetCourseSection response = GetCourseSection.fromJson(json);
        return response;
      }return null;
    }catch(e){
      return null;
    }
  }

  Future postCourseAnalysis(context, CourseAnalysisRequest body) async{
    try{
      Map<String, String> header_ = await authHeader();
      var json = await postRequest(courseAnalysisUrl, header_, body.toJson(), context);
      if(json != null){
        return CourseAnalysisResponse.fromJson(json);
      } return null;
    }catch(e){
      return null;
    }
  }
  
  Future courseByIdRepo(context, String courseId)async{
    try{
      Map<String, String> header_ = await authHeader();
      var json = await getRequest(getCourseById(courseId), header_, context);
      if(json != null){
        SingleCourseModel response =  SingleCourseModel.fromJson(json);
        if(response.responseCode == "00"){
          return response.responseData;
        }
      }
      return null;
    }catch(e){
      return null;
    }
  }
  
  Future saveReviewRepo(context, SaveReviewRequest body)async{
    try{
      Map<String, String> header_ = await authHeader();
      var json = await postRequest(saveReviewUrl, header_, body.toJson(), context);
      if(json != null){
        return SaveReviewResponse.fromJson(json);
      }
      return null;
    }catch(e){
      return;
    }
  }
}
