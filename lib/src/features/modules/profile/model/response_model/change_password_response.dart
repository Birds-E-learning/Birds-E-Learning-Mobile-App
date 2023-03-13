class ChangePasswordResponse {
  String? responseCode;
  String? responseMessage;
  ResponseData? responseData;

  ChangePasswordResponse({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  ChangePasswordResponse.fromJson(Map<String, dynamic> json) {
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
  String? userEmail;
  String? userId;
  String? updatedAt;

  ResponseData({
    this.userEmail,
    this.userId,
    this.updatedAt,
  });

  ResponseData.fromJson(Map<String, dynamic> json) {
    userEmail = json['userEmail'] as String?;
    userId = json['userId'] as String?;
    updatedAt = json['updatedAt'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['userEmail'] = userEmail;
    json['userId'] = userId;
    json['updatedAt'] = updatedAt;
    return json;
  }
}
