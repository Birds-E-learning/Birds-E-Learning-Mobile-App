class SavePreferenceModel {
  String? userEmail;
  String? channel;
  String? deviceId;
  List<String>? preferenceList;

  SavePreferenceModel({
    this.userEmail,
    this.channel = "MOBILE",
    this.deviceId,
    this.preferenceList,
  });

  SavePreferenceModel.fromJson(Map<String, dynamic> json) {
    userEmail = json['userEmail'] as String?;
    channel = json['channel'] as String?;
    deviceId = json['deviceId'] as String?;
    preferenceList = (json['preferenceList'] as List?)
        ?.map((dynamic e) => e as String)
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['userEmail'] = userEmail;
    json['channel'] = channel;
    json['deviceId'] = deviceId;
    json['preferenceList'] = preferenceList;
    return json;
  }
}
