import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';

class GetCourseSection {
  String? responseCode;
  String? responseMessage;
  List<Sections>? responseData;

  GetCourseSection({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  GetCourseSection.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'] as String?;
    responseMessage = json['responseMessage'] as String?;
    responseData = (json['responseData'] as List?)
        ?.map((dynamic e) => Sections.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
