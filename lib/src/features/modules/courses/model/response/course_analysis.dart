class CourseAnalysisResponse {
  final String? responseCode;
  final String? responseMessage;
  final dynamic responseData;

  CourseAnalysisResponse({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  CourseAnalysisResponse.fromJson(Map<String, dynamic> json)
      : responseCode = json['responseCode'] as String?,
        responseMessage = json['responseMessage'] as String?,
        responseData = json['responseData'];

  Map<String, dynamic> toJson() => {
    'responseCode' : responseCode,
    'responseMessage' : responseMessage,
    'responseData' : responseData
  };
}