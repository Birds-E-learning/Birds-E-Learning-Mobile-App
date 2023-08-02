class BlogNewsResponse {
  final String? responseCode;
  final String? responseMessage;
  final List<NewsData>? responseData;

  BlogNewsResponse({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  BlogNewsResponse.fromJson(Map<String, dynamic> json)
      : responseCode = json['responseCode'] as String?,
        responseMessage = json['responseMessage'] as String?,
        responseData = (json['responseData'] as List?)?.map((dynamic e) => NewsData.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'responseCode' : responseCode,
    'responseMessage' : responseMessage,
    'responseData' : responseData?.map((e) => e.toJson()).toList()
  };
}

class NewsData {
  final String? title;
  final String? content;
  final String? slug;
  final int? categoryId;
  final String? imageUrl;
  final String? createdAt;
  final String? updatedAt;
  final String? author;

  NewsData({
    this.title,
    this.content,
    this.slug,
    this.categoryId,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
    this.author,
  });

  NewsData.fromJson(Map<String, dynamic> json)
      : title = json['title'] as String?,
        content = json['content'] as String?,
        slug = json['slug'] as String?,
        categoryId = json['categoryId'] as int?,
        imageUrl = json['imageUrl'] as String?,
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?,
        author = json['author'] as String?;

  Map<String, dynamic> toJson() => {
    'title' : title,
    'content' : content,
    'slug' : slug,
    'categoryId' : categoryId,
    'imageUrl' : imageUrl,
    'createdAt' : createdAt,
    'updatedAt' : updatedAt,
    'author' : author
  };
}