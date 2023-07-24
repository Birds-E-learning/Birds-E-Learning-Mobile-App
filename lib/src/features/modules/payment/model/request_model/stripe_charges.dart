class StripeChargesRequest {
  String? amount;
  String? currency;
  String? description;
  String? token;
  String? courseId;

  StripeChargesRequest({
    this.amount,
    this.currency,
    this.description,
    this.token,
    this.courseId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['amount'] = amount;
    json['currency'] = currency;
    json['description'] = description;
    json['token'] = token;
    json['courseId'] = courseId;
    return json;
  }
}
