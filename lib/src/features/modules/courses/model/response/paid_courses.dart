import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';

class PaidCoursesResponse {
  String? responseCode;
  String? responseMessage;
  List<Courses>? responseData;

  PaidCoursesResponse({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  PaidCoursesResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'] as String?;
    responseMessage = json['responseMessage'] as String?;
    responseData = (json['responseData'] as List?)
        ?.map((dynamic e) => Courses.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}

class ResponseData {
  String? id;
  String? title;
  String? slug;
  String? content;
  int? imageId;
  int? bannerImageId;
  String? shortDesc;
  int? categoryId;
  int? isFeatured;
  String? gallery;
  String? video;
  String? price;
  String? salePrice;
  int? duration;
  dynamic faqs;
  String? status;
  dynamic publishDate;
  String? createUser;
  String? updateUser;
  dynamic deletedAt;
  String? views;
  String? createdAt;
  String? updatedAt;
  int? defaultState;
  dynamic reviewScore;
  dynamic include;
  dynamic exclude;
  dynamic itinerary;
  String? imageUrl;
  String? imageBannerUrl;
  Facilitator? facilitator;

  ResponseData({
    this.id,
    this.title,
    this.slug,
    this.content,
    this.imageId,
    this.bannerImageId,
    this.shortDesc,
    this.categoryId,
    this.isFeatured,
    this.gallery,
    this.video,
    this.price,
    this.salePrice,
    this.duration,
    this.faqs,
    this.status,
    this.publishDate,
    this.createUser,
    this.updateUser,
    this.deletedAt,
    this.views,
    this.createdAt,
    this.updatedAt,
    this.defaultState,
    this.reviewScore,
    this.include,
    this.exclude,
    this.itinerary,
    this.imageUrl,
    this.imageBannerUrl,
    this.facilitator,
  });

  ResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    title = json['title'] as String?;
    slug = json['slug'] as String?;
    content = json['content'] as String?;
    imageId = json['imageId'] as int?;
    bannerImageId = json['bannerImageId'] as int?;
    shortDesc = json['shortDesc'] as String?;
    categoryId = json['categoryId'] as int?;
    isFeatured = json['isFeatured'] as int?;
    gallery = json['gallery'] as String?;
    video = json['video'] as String?;
    price = json['price'] as String?;
    salePrice = json['salePrice'] as String?;
    duration = json['duration'] as int?;
    faqs = json['faqs'];
    status = json['status'] as String?;
    publishDate = json['publishDate'];
    createUser = json['createUser'] as String?;
    updateUser = json['updateUser'] as String?;
    deletedAt = json['deletedAt'];
    views = json['views'] as String?;
    createdAt = json['createdAt'] as String?;
    updatedAt = json['updatedAt'] as String?;
    defaultState = json['defaultState'] as int?;
    reviewScore = json['reviewScore'];
    include = json['include'];
    exclude = json['exclude'];
    itinerary = json['itinerary'];
    imageUrl = json['imageUrl'] as String?;
    imageBannerUrl = json['imageBannerUrl'] as String?;
    facilitator = (json['facilitator'] as Map<String, dynamic>?) != null
        ? Facilitator.fromJson(json['facilitator'] as Map<String, dynamic>)
        : null;
  }
}

class Facilitator {
  String? id;
  String? email;
  String? name;
  String? degree;
  String? skill;
  int? reviews;
  int? ratings;
  int? students;
  String? imageUrl;

  Facilitator({
    this.id,
    this.email,
    this.name,
    this.degree,
    this.skill,
    this.reviews,
    this.ratings,
    this.students,
    this.imageUrl,
  });

  Facilitator.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    email = json['email'] as String?;
    name = json['name'] as String?;
    degree = json['degree'] as String?;
    skill = json['skill'] as String?;
    reviews = json['reviews'] as int?;
    ratings = json['ratings'] as int?;
    students = json['students'] as int?;
    imageUrl = json['imageUrl'] as String?;
  }
}
