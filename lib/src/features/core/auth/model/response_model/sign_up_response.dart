class SignUpResponse {
  String? responseCode;
  String? responseMessage;
  ResponseData? responseData;

  SignUpResponse({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  SignUpResponse.fromJson(Map<String, dynamic> json) {
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
  String? emailAddress;
  String? username;
  String? createdDate;
  String? deviceId;

  ResponseData({
    this.emailAddress,
    this.username,
    this.createdDate,
    this.deviceId,
  });

  ResponseData.fromJson(Map<String, dynamic> json) {
    emailAddress = json['emailAddress'] as String?;
    username = json['username'] as String?;
    createdDate = json['createdDate'] as String?;
    deviceId = json['deviceId'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['emailAddress'] = emailAddress;
    json['username'] = username;
    json['createdDate'] = createdDate;
    json['deviceId'] = deviceId;
    return json;
  }
}
