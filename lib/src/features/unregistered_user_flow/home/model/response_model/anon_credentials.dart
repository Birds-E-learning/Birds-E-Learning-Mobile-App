class AnonymousCredentialResponse {
  final String? responseCode;
  final String? responseMessage;
  final ResponseData? responseData;

  AnonymousCredentialResponse({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  AnonymousCredentialResponse.fromJson(Map<String, dynamic> json)
      : responseCode = json['responseCode'] as String?,
        responseMessage = json['responseMessage'] as String?,
        responseData = (json['responseData'] as Map<String,dynamic>?) != null ? ResponseData.fromJson(json['responseData'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'responseCode' : responseCode,
    'responseMessage' : responseMessage,
    'responseData' : responseData?.toJson()
  };
}

class ResponseData {
  final String? authToken;

  ResponseData({
    this.authToken,
  });

  ResponseData.fromJson(Map<String, dynamic> json)
      : authToken = json['authToken'] as String?;

  Map<String, dynamic> toJson() => {
    'authToken' : authToken
  };
}