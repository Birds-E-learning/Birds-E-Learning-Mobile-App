class BlogCategoryResponse {
  final String? responseCode;
  final String? responseMessage;
  final List<CategoryData>? responseData;

  BlogCategoryResponse({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  BlogCategoryResponse.fromJson(Map<String, dynamic> json)
      : responseCode = json['responseCode'] as String?,
        responseMessage = json['responseMessage'] as String?,
        responseData = (json['responseData'] as List?)?.map((dynamic e) => CategoryData.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'responseCode' : responseCode,
    'responseMessage' : responseMessage,
    'responseData' : responseData?.map((e) => e.toJson()).toList()
  };
}

class CategoryData {
  final String? id;
  final String? name;
  final String? slug;
  final String? status;
  final String? defaultImageUrl;
  final String? createdAt;
  final String? updatedAt;

  CategoryData({
    this.id,
    this.name,
    this.slug,
    this.status,
    this.defaultImageUrl,
    this.createdAt,
    this.updatedAt,
  });

  CategoryData.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        name = json['name'] as String?,
        slug = json['slug'] as String?,
        status = json['status'] as String?,
        defaultImageUrl = json['defaultImageUrl'] as String?,
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'slug' : slug,
    'status' : status,
    'defaultImageUrl' : defaultImageUrl,
    'createdAt' : createdAt,
    'updatedAt' : updatedAt
  };
}