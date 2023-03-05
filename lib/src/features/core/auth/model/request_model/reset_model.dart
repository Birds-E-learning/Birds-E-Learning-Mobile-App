class ResetModel {
  String? newPassword;
  String? emailAddress;

  ResetModel({
    this.newPassword,
    this.emailAddress,
  });

  ResetModel.fromJson(Map<String, dynamic> json) {
    newPassword = json['newPassword'] as String?;
    emailAddress = json['emailAddress'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['newPassword'] = newPassword;
    json['emailAddress'] = emailAddress;
    return json;
  }
}
