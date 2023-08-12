import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';

class PaidCoursesResponse {
  String? responseCode;
  String? responseMessage;
  List<Courses>? responseData;

  PaidCoursesResponse({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  PaidCoursesResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'] as String?;
    responseMessage = json['responseMessage'] as String?;
    responseData = (json['responseData'] as List?)
        ?.map((dynamic e) => Courses.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

