class AuthConsentModel {
  String? consentCode;
  String? state;
  String? authServiceProvider;
  String? channel;
  String? deviceId;
  String? oauthValidationType;

  AuthConsentModel({
    this.consentCode,
    this.state,
    this.authServiceProvider,
    this.channel = "MOBILE",
    this.deviceId,
    this.oauthValidationType,
  });

  AuthConsentModel.fromJson(Map<String, dynamic> json) {
    consentCode = json['consentCode'] as String?;
    state = json['state'] as String?;
    authServiceProvider = json['authServiceProvider'] as String?;
    channel = json['channel'] as String?;
    deviceId = json['deviceId'] as String?;
    oauthValidationType = json['oauthValidationType'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['consentCode'] = consentCode;
    json['state'] = state;
    json['authServiceProvider'] = authServiceProvider;
    json['channel'] = channel;
    json['deviceId'] = deviceId;
    json['oauthValidationType'] = oauthValidationType;
    return json;
  }
}
