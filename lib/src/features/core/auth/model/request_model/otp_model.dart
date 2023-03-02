class OtpModel {
  String? otp;
  String? userEmail;

  OtpModel({
    this.otp,
    this.userEmail,
  });

  OtpModel.fromJson(Map<String, dynamic> json) {
    otp = json['otp'] as String?;
    userEmail = json['userEmail'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['otp'] = otp;
    json['userEmail'] = userEmail;
    return json;
  }
}
