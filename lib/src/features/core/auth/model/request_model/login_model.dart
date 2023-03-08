class LoginModel {
  String? email;
  String? password;
  String? channel;
  String? deviceId;
  bool? rememberMe;
  String? loginBy;

  LoginModel({
    this.email,
    this.password,
    this.channel = "MOBILE",
    this.deviceId,
    this.rememberMe = false,
    this.loginBy = "LOCAL_DOMAIN",
  });

  LoginModel.fromJson(Map<String, dynamic> json) {
    email = json['email'] as String?;
    password = json['password'] as String?;
    channel = json['channel'] as String?;
    deviceId = json['deviceId'] as String?;
    rememberMe = json['rememberMe'] as bool?;
    loginBy = json['loginBy'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['email'] = email;
    json['password'] = password;
    json['deviceId'] = deviceId;
    json['channel'] = channel;
    json['rememberMe'] = rememberMe;
    json['loginBy'] = loginBy;
    return json;
  }
}
