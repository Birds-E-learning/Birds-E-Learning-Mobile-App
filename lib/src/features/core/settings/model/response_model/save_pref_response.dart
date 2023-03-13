class SavePreferenceResponse {
  String? responseCode;
  String? responseMessage;
  ResponseData? responseData;

  SavePreferenceResponse({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  SavePreferenceResponse.fromJson(Map<String, dynamic> json) {
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
  dynamic id;
  String? userId;
  String? userEmail;
  List<String>? preferenceNames;
  String? createdDate;
  String? updatedDate;

  ResponseData({
    this.id,
    this.userId,
    this.userEmail,
    this.preferenceNames,
    this.createdDate,
    this.updatedDate,
  });

  ResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'] as dynamic;
    userId = json['userId'] as String?;
    userEmail = json['userEmail'] as String?;
    preferenceNames = (json['preferenceNames'] as List?)
        ?.map((dynamic e) => e as String)
        .toList();
    createdDate = json['createdDate'] as String?;
    updatedDate = json['updatedDate'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['id'] = id;
    json['userId'] = userId;
    json['userEmail'] = userEmail;
    json['preferenceNames'] = preferenceNames;
    json['createdDate'] = createdDate;
    json['updatedDate'] = updatedDate;
    return json;
  }
}
