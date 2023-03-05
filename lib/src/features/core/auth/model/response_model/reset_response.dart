class ResetResponse {
  String? responseCode;
  String? responseMessage;
  ResponseData? responseData;

  ResetResponse({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  ResetResponse.fromJson(Map<String, dynamic> json) {
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
  String? newPassword;
  String? dateUpdated;

  ResponseData({
    this.newPassword,
    this.dateUpdated,
  });

  ResponseData.fromJson(Map<String, dynamic> json) {
    newPassword = json['newPassword'] as String?;
    dateUpdated = json['dateUpdated'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['newPassword'] = newPassword;
    json['dateUpdated'] = dateUpdated;
    return json;
  }
}
