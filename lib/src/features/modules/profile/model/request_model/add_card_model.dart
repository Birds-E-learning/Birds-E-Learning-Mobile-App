class AddCardModel {
  String? cardNo;
  String? expiryDate;
  String? cvv;

  AddCardModel({
    this.cardNo,
    this.expiryDate,
    this.cvv,
  });

  AddCardModel.fromJson(Map<String, dynamic> json) {
    cardNo = json['cardNo'] as String?;
    expiryDate = json['expiryDate'] as String?;
    cvv = json['cvv'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['cardNo'] = cardNo;
    json['expiryDate'] = expiryDate;
    json['cvv'] = cvv;
    return json;
  }
}
