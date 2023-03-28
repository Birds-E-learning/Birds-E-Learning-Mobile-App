import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';

class GetAllCoursesResponse {
  String? responseCode;
  String? responseMessage;
  List<Courses>? responseData;

  GetAllCoursesResponse({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  GetAllCoursesResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'] as String?;
    responseMessage = json['responseMessage'] as String?;
    responseData = (json['responseData'] as List?)
        ?.map((dynamic e) => Courses.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
