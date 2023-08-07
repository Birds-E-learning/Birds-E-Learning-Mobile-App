import 'package:birds_learning_network/src/features/core/auth/model/response_model/login_response.dart';

class SubscriptionLatestResponse {
  final String? responseCode;
  final String? responseMessage;
  final SubscriptionModel? responseData;

  SubscriptionLatestResponse({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  SubscriptionLatestResponse.fromJson(Map<String, dynamic> json)
      : responseCode = json['responseCode'] as String?,
        responseMessage = json['responseMessage'] as String?,
        responseData = (json['responseData'] as Map<String, dynamic>?) != null
            ? SubscriptionModel.fromJson(
            json['responseData'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() =>
      {
        'responseCode': responseCode,
        'responseMessage': responseMessage,
        'responseData': responseData?.toJson()
      };
}