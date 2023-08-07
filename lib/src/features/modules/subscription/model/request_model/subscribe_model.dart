class SubscriptionPaymentRequest {
  final String? amount;
  final String? currency;
  final String? description;
  final String? token;
  final String? subscriptionSlug;

  SubscriptionPaymentRequest({
    this.amount,
    this.currency,
    this.description,
    this.token,
    this.subscriptionSlug,
  });

  SubscriptionPaymentRequest.fromJson(Map<String, dynamic> json)
      : amount = json['amount'] as String?,
        currency = json['currency'] as String?,
        description = json['description'] as String?,
        token = json['token'] as String?,
        subscriptionSlug = json['subscriptionSlug'] as String?;

  Map<String, dynamic> toJson() => {
    'amount' : amount,
    'currency' : currency,
    'description' : description,
    'token' : token,
    'subscriptionSlug' : subscriptionSlug
  };
}