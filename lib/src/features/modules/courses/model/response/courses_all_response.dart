import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';

class GetCoursesAllResponse {
  String? responseCode;
  String? responseMessage;
  ResponseData? responseData;

  GetCoursesAllResponse({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  GetCoursesAllResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'] as String?;
    responseMessage = json['responseMessage'] as String?;
    responseData = (json['responseData'] as Map<String, dynamic>?) != null
        ? ResponseData.fromJson(json['responseData'] as Map<String, dynamic>)
        : null;
  }
}

class ResponseData {
  List<Courses>? courses;

  ResponseData({
    this.courses,
  });

  ResponseData.fromJson(Map<String, dynamic> json) {
    courses = (json['courses'] as List?)
        ?.map((dynamic e) => Courses.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
