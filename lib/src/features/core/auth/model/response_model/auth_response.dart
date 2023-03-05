class OAuthResponse {
  String? responseCode;
  String? responseMessage;
  ResponseData? responseData;

  OAuthResponse({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  OAuthResponse.fromJson(Map<String, dynamic> json) {
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
  String? authorizationConsentUrl;

  ResponseData({
    this.authorizationConsentUrl,
  });

  ResponseData.fromJson(Map<String, dynamic> json) {
    authorizationConsentUrl = json['authorizationConsentUrl'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['authorizationConsentUrl'] = authorizationConsentUrl;
    return json;
  }
}
