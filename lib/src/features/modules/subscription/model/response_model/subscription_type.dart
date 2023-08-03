class SubscriptionDurationModel {
  final String? responseCode;
  final String? responseMessage;
  final List<DurationData>? responseData;

  SubscriptionDurationModel({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  SubscriptionDurationModel.fromJson(Map<String, dynamic> json)
      : responseCode = json['responseCode'] as String?,
        responseMessage = json['responseMessage'] as String?,
        responseData = (json['responseData'] as List?)?.map((dynamic e) => DurationData.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'responseCode' : responseCode,
    'responseMessage' : responseMessage,
    'responseData' : responseData?.map((e) => e.toJson()).toList()
  };
}

class DurationData {
  final String? slug;
  final String? duration;
  final String? createdAt;
  final String? updatedAt;
  final int? amount;
  final dynamic currency;

  DurationData({
    this.slug,
    this.duration,
    this.createdAt,
    this.updatedAt,
    this.amount,
    this.currency,
  });

  DurationData.fromJson(Map<String, dynamic> json)
      : slug = json['slug'] as String?,
        duration = json['duration'] as String?,
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?,
        amount = json['amount'] as int?,
        currency = json['currency'] as dynamic;

  Map<String, dynamic> toJson() => {
    'slug' : slug,
    'duration' : duration,
    'createdAt' : createdAt,
    'updatedAt' : updatedAt,
    'amount' : amount,
    'currency' : currency?.toJson()
  };
}

