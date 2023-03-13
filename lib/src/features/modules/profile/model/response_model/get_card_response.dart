class GetDebitCardResponse {
  String? responseCode;
  String? responseMessage;
  List<CardResponseData>? responseData;

  GetDebitCardResponse({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  GetDebitCardResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'] as String?;
    responseMessage = json['responseMessage'] as String?;
    responseData = (json['responseData'] as List?)
        ?.map(
            (dynamic e) => CardResponseData.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['responseCode'] = responseCode;
    json['responseMessage'] = responseMessage;
    json['responseData'] = responseData?.map((e) => e.toJson()).toList();
    return json;
  }
}

class CardResponseData {
  String? userEmail;
  String? userId;
  String? cardNo;
  String? expiryDate;
  String? cvv;
  String? cardType;
  String? createdDate;
  String? updatedAt;

  CardResponseData({
    this.userEmail,
    this.userId,
    this.cardNo,
    this.expiryDate,
    this.cvv,
    this.cardType,
    this.createdDate,
    this.updatedAt,
  });

  CardResponseData.fromJson(Map<String, dynamic> json) {
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
