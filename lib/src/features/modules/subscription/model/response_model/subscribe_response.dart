class SubscriptionPaymentResponse {
  final String? responseCode;
  final String? responseMessage;
  final SubscriptionResponseData? responseData;

  SubscriptionPaymentResponse({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  SubscriptionPaymentResponse.fromJson(Map<String, dynamic> json)
      : responseCode = json['responseCode'] as String?,
        responseMessage = json['responseMessage'] as String?,
        responseData = (json['responseData'] as Map<String, dynamic>?) != null
            ? SubscriptionResponseData.fromJson(json['responseData'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {
    'responseCode' : responseCode,
    'responseMessage' : responseMessage,
    'responseData' : responseData?.toJson()
  };
}

class SubscriptionResponseData {
  final String? slug;
  final String? duration;
  final String? createdAt;
  final String? updatedAt;
  final dynamic amount;
  final dynamic currency;
  final String? status;

  SubscriptionResponseData({
    this.slug,
    this.duration,
    this.createdAt,
    this.updatedAt,
    this.amount,
    this.currency,
    this.status,
  });

  SubscriptionResponseData.fromJson(Map<String, dynamic> json)
      : slug = json['slug'] as String?,
        duration = json['duration'] as String?,
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?,
        status = json['status'] as String?,
        amount = json['amount'] as dynamic,
        currency = json['currency'] as dynamic;

  Map<String, dynamic> toJson() =>
      {
        'slug': slug,
        'duration': duration,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'amount': amount,
        'currency': currency,
        'status' : status,
      };
}