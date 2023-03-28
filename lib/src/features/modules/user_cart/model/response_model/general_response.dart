class GeneralCartResponse {
  String? responseCode;
  String? responseMessage;

  GeneralCartResponse({
    this.responseCode,
    this.responseMessage,
  });

  GeneralCartResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'] as String?;
    responseMessage = json['responseMessage'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['responseCode'] = responseCode;
    json['responseMessage'] = responseMessage;
    return json;
  }
}
