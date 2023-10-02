import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';

class SingleCourseModel {
  final String? responseCode;
  final String? responseMessage;
  final Courses? responseData;

  SingleCourseModel({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  SingleCourseModel.fromJson(Map<String, dynamic> json)
      : responseCode = json['responseCode'] as String?,
        responseMessage = json['responseMessage'] as String?,
        responseData = (json['responseData'] as Map<String,dynamic>?) != null ? Courses.fromJson(json['responseData'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'responseCode' : responseCode,
    'responseMessage' : responseMessage,
    'responseData' : responseData?.toJson()
  };
}
