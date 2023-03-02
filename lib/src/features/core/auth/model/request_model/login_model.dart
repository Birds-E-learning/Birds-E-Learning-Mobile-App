class LoginModel {
  String? email;
  String? password;

  LoginModel({
    this.email,
    this.password,
  });

  LoginModel.fromJson(Map<String, dynamic> json) {
    email = json['email'] as String?;
    password = json['password'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['email'] = email;
    json['password'] = password;
    return json;
  }
}
