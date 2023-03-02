class OtpResponse {
  String? responseCode;
  String? responseMessage;
  ResponseData? responseData;

  OtpResponse({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  OtpResponse.fromJson(Map<String, dynamic> json) {
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
  String? otpValidatedDate;
  String? userStatus;

  ResponseData({
    this.userEmail,
    this.otpValidatedDate,
    this.userStatus,
  });

  ResponseData.fromJson(Map<String, dynamic> json) {
    userEmail = json['userEmail'] as String?;
    otpValidatedDate = json['otpValidatedDate'] as String?;
    userStatus = json['userStatus'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['userEmail'] = userEmail;
    json['otpValidatedDate'] = otpValidatedDate;
    json['userStatus'] = userStatus;
    return json;
  }
}
