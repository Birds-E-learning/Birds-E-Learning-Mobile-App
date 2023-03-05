class AutomaticLoginModel {
  String? deviceId;
  String? channel;

  AutomaticLoginModel({
    this.deviceId = "",
    this.channel = "MOBILE",
  });

  AutomaticLoginModel.fromJson(Map<String, dynamic> json) {
    deviceId = json['deviceId'] as String?;
    channel = json['channel'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['deviceId'] = deviceId;
    json['channel'] = channel;
    return json;
  }
}
