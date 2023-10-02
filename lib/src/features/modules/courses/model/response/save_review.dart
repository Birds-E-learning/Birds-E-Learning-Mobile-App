class SaveReviewResponse {
  final String? responseCode;
  final String? responseMessage;

  SaveReviewResponse({
    this.responseCode,
    this.responseMessage,
  });

  SaveReviewResponse.fromJson(Map<String, dynamic> json)
      : responseCode = json['responseCode'] as String?,
        responseMessage = json['responseMessage'] as String?;

  Map<String, dynamic> toJson() => {
    'responseCode' : responseCode,
    'responseMessage' : responseMessage
  };
}