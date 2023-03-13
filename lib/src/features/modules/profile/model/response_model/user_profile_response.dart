class UpdateProfileResponse {
  String? responseCode;
  String? responseMessage;
  ResponseData? responseData;

  UpdateProfileResponse({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  UpdateProfileResponse.fromJson(Map<String, dynamic> json) {
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
  String? newEmail;
  String? newMobileNumber;
  String? newFirstName;
  String? newMiddleName;
  String? newLastName;
  String? newGender;
  String? updatedAt;
  String? updatedBy;

  ResponseData({
    this.newEmail,
    this.newMobileNumber,
    this.newFirstName,
    this.newMiddleName,
    this.newLastName,
    this.newGender,
    this.updatedAt,
    this.updatedBy,
  });

  ResponseData.fromJson(Map<String, dynamic> json) {
    newEmail = json['newEmail'] as String?;
    newMobileNumber = json['newMobileNumber'] as String?;
    newFirstName = json['newFirstName'] as String?;
    newMiddleName = json['newMiddleName'] as String?;
    newLastName = json['newLastName'] as String?;
    newGender = json['newGender'] as String?;
    updatedAt = json['updatedAt'] as String?;
    updatedBy = json['updatedBy'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['newEmail'] = newEmail;
    json['newMobileNumber'] = newMobileNumber;
    json['newFirstName'] = newFirstName;
    json['newMiddleName'] = newMiddleName;
    json['newLastName'] = newLastName;
    json['newGender'] = newGender;
    json['updatedAt'] = updatedAt;
    json['updatedBy'] = updatedBy;
    return json;
  }
}
