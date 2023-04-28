class StripePaymentModel {
  String? amount;
  String? currency;
  String? paymentMethodTypes;

  StripePaymentModel({
    this.amount,
    this.currency,
    this.paymentMethodTypes,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['amount'] = amount;
    json['currency'] = currency;
    json['payment_method_types[]'] = paymentMethodTypes;
    return json;
  }
}
