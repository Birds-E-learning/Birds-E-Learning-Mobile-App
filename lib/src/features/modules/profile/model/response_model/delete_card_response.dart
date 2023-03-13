class DeleteCardResponse {
  String? responseCode;
  String? responseMessage;
  ResponseData? responseData;

  DeleteCardResponse({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  DeleteCardResponse.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  String? cardNo;
  String? expiryDate;
  String? cvv;
  String? cardType;
  String? createdDate;
  String? updatedAt;

  ResponseData({
    this.userEmail,
    this.userId,
    this.cardNo,
    this.expiryDate,
    this.cvv,
    this.cardType,
    this.createdDate,
    this.updatedAt,
  });

  ResponseData.fromJson(Map<String, dynamic> json) {
    userEmail = json['userEmail'] as String?;
    userId = json['userId'] as String?;
    cardNo = json['cardNo'] as String?;
    expiryDate = json['expiryDate'] as String?;
    cvv = json['cvv'] as String?;
    cardType = json['cardType'] as String?;
    createdDate = json['createdDate'] as String?;
    updatedAt = json['updatedAt'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['userEmail'] = userEmail;
    json['userId'] = userId;
    json['cardNo'] = cardNo;
    json['expiryDate'] = expiryDate;
    json['cvv'] = cvv;
    json['cardType'] = cardType;
    json['createdDate'] = createdDate;
    json['updatedAt'] = updatedAt;
    return json;
  }
}
