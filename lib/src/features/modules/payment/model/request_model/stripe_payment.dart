class StripePaymentRequest {
  String? cardNo;
  String? expiryDate;
  String? ccv;
  String? pin;
  String? amount;

  StripePaymentRequest({
    this.cardNo,
    this.expiryDate,
    this.ccv,
    this.pin,
    this.amount,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['cardNo'] = cardNo;
    json['expiryDate'] = expiryDate;
    json['ccv'] = ccv;
    json['pin'] = pin;
    json['amount'] = amount;
    return json;
  }
}
