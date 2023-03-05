class AuthModel {
  String? authServiceProvider;
  String? channel;
  String? deviceId;

  AuthModel({
    this.authServiceProvider,
    this.channel = "MOBILE",
    this.deviceId,
  });

  AuthModel.fromJson(Map<String, dynamic> json) {
    authServiceProvider = json['authServiceProvider'] as String?;
    channel = json['channel'] as String?;
    deviceId = json['deviceId'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['authServiceProvider'] = authServiceProvider;
    json['channel'] = channel;
    json['deviceId'] = deviceId;
    return json;
  }
}
