class StripeKeyResponse {
  String? responseCode;
  String? responseMessage;
  ResponseData? responseData;

  StripeKeyResponse({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  StripeKeyResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'] as String?;
    responseMessage = json['responseMessage'] as String?;
    responseData = (json['responseData'] as Map<String, dynamic>?) != null
        ? ResponseData.fromJson(json['responseData'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['responseCode'] = responseCode;
    json['responseMessage'] = responseMessage;
    json['responseData'] = responseData?.toJson();
    return json;
  }
}

class ResponseData {
  String? publishableKey;
  String? secretKey;

  ResponseData({
    this.publishableKey,
    this.secretKey,
  });

  ResponseData.fromJson(Map<String, dynamic> json) {
    publishableKey = json['publishableKey'] as String?;
    secretKey = json['secretKey'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['publishableKey'] = publishableKey;
    json['secretKey'] = secretKey;
    return json;
  }
}
