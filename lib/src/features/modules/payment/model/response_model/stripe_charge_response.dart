class StripeChargesResponse {
  String? responseCode;
  String? responseMessage;
  ResponseData? responseData;

  StripeChargesResponse({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  StripeChargesResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'] as String?;
    responseMessage = json['responseMessage'] as String?;
    responseData = (json['responseData'] as Map<String, dynamic>?) != null
        ? ResponseData.fromJson(json['responseData'] as Map<String, dynamic>)
        : null;
  }
}

class ResponseData {
  dynamic amount;
  dynamic amountCaptured;
  String? transactionId;
  String? balanceTransaction;
  bool? isStripeCaptured;
  bool? paid;
  String? calculatedStatementDescriptor;
  String? description;
  String? status;

  ResponseData({
    this.amount,
    this.amountCaptured,
    this.transactionId,
    this.balanceTransaction,
    this.isStripeCaptured,
    this.paid,
    this.calculatedStatementDescriptor,
    this.description,
    this.status,
  });

  ResponseData.fromJson(Map<String, dynamic> json) {
    amount = json['amount'] as dynamic;
    amountCaptured = json['amountCaptured'] as dynamic;
    transactionId = json['transactionId'] as String?;
    balanceTransaction = json['balanceTransaction'] as String?;
    isStripeCaptured = json['isStripeCaptured'] as bool?;
    paid = json['paid'] as bool?;
    calculatedStatementDescriptor =
        json['calculatedStatementDescriptor'] as String?;
    description = json['description'] as String?;
    status = json['status'] as String?;
  }
}
