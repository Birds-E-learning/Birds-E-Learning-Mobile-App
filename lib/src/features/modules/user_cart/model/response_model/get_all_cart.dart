import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';

class GetCartResponse {
  String? responseCode;
  String? responseMessage;
  List<Courses>? responseData;

  GetCartResponse({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  GetCartResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'] as String?;
    responseMessage = json['responseMessage'] as String?;
    responseData = (json['responseData'] as List?)
        ?.map((dynamic e) => Courses.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
