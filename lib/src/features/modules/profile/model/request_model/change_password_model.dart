class ChangePasswordModel {
  String? oldPassword;
  String? newPassword;

  ChangePasswordModel({
    this.oldPassword,
    this.newPassword,
  });

  ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    oldPassword = json['oldPassword'] as String?;
    newPassword = json['newPassword'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['oldPassword'] = oldPassword;
    json['newPassword'] = newPassword;
    return json;
  }
}
