class GetPreferenceModel {
  String? responseCode;
  String? responseMessage;
  List<PreferenceResponseData>? responseData;

  GetPreferenceModel({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  GetPreferenceModel.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'] as String?;
    responseMessage = json['responseMessage'] as String?;
    responseData = (json['responseData'] as List?)
        ?.map((dynamic e) =>
            PreferenceResponseData.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['responseCode'] = responseCode;
    json['responseMessage'] = responseMessage;
    json['responseData'] = responseData?.map((e) => e.toJson()).toList();
    return json;
  }
}

class PreferenceResponseData {
  String? name;
  dynamic imageId;
  String? content;
  String? slug;
  String? status;
  String? language;
  String? createdAt;
  String? updatedAt;

  PreferenceResponseData({
    this.name,
    this.imageId,
    this.content,
    this.slug,
    this.status,
    this.language,
    this.createdAt,
    this.updatedAt,
  });

  PreferenceResponseData.fromJson(Map<String, dynamic> json) {
    name = json['name'] as String?;
    imageId = json['imageId'] as dynamic;
    content = json['content'] as String?;
    slug = json['slug'] as String?;
    status = json['status'] as String?;
    language = json['language'] as String?;
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['name'] = name;
    json['imageId'] = imageId;
    json['content'] = content;
    json['slug'] = slug;
    json['status'] = status;
    json['language'] = language;
    json['createdAt'] = createdAt;
    json['updatedAt'] = updatedAt;
    return json;
  }
}
