class AuthJsonModel {
  String? code;
  String? state;

  AuthJsonModel({
    this.code,
    this.state,
  });

  AuthJsonModel.fromJson(Map<String, dynamic> json) {
    code = json['code'] as String?;
    state = json['state'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['code'] = code;
    json['state'] = state;
    return json;
  }
}
