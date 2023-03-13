class DebitCardModel {
  String? cardNo;
  String? cardType;
  String? expiryDate;

  DebitCardModel({
    this.cardNo,
    this.cardType,
    this.expiryDate,
  });

  DebitCardModel.fromJson(Map<String, dynamic> json) {
    cardNo = json['cardNo'] as String?;
    cardType = json['cardType'] as String?;
    expiryDate = json['expiryDate'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['cardNo'] = cardNo;
    json['cardType'] = cardType;
    json['expiryDate'] = expiryDate;
    return json;
  }
}
