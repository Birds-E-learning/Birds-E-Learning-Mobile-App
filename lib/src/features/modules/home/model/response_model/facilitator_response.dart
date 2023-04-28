import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';

class FacilitatorResponse {
  String? responseCode;
  String? responseMessage;
  ResponseData? responseData;

  FacilitatorResponse({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  FacilitatorResponse.fromJson(Map<String, dynamic> json) {
    responseCode = json['responseCode'] as String?;
    responseMessage = json['responseMessage'] as String?;
    responseData = (json['responseData'] as Map<String, dynamic>?) != null
        ? ResponseData.fromJson(json['responseData'] as Map<String, dynamic>)
        : null;
  }
}

class ResponseData {
  String? imageUrl;
  String? firstName;
  String? middleName;
  String? emailAddress;
  String? lastName;
  String? aboutMe;
  int? numberOfCourses;
  List<Courses>? courses;
  int? averageRating;
  int? numberOfStudents;

  ResponseData({
    this.imageUrl,
    this.firstName,
    this.middleName,
    this.lastName,
    this.aboutMe,
    this.emailAddress,
    this.numberOfCourses,
    this.courses,
    this.averageRating,
    this.numberOfStudents,
  });

  ResponseData.fromJson(Map<String, dynamic> json) {
    imageUrl = json['imageUrl'] as String?;
    firstName = json['firstName'] as String?;
    middleName = json['middleName'] as String?;
    emailAddress = json["emailAddress"] as String?;
    lastName = json['lastName'] as String?;
    aboutMe = json['aboutMe'] as String?;
    numberOfCourses = json['numberOfCourses'] as int?;
    courses = (json['courses'] as List?)
        ?.map((dynamic e) => Courses.fromJson(e as Map<String, dynamic>))
        .toList();
    averageRating = json['averageRating'] as int?;
    numberOfStudents = json['numberOfStudents'] as int?;
  }
}

// class FacilitatorCourses {
//   String? id;
//   String? title;
//   String? slug;
//   String? content;
//   int? imageId;
//   int? bannerImageId;
//   String? shortDesc;
//   int? categoryId;
//   int? isFeatured;
//   String? gallery;
//   String? video;
//   String? price;
//   String? salePrice;
//   int? duration;
//   dynamic faqs;
//   String? status;
//   dynamic publishDate;
//   String? createUser;
//   dynamic updateUser;
//   dynamic deletedAt;
//   dynamic views;
//   String? createdAt;
//   dynamic updatedAt;
//   int? defaultState;
//   dynamic reviewScore;
//   dynamic include;
//   dynamic exclude;
//   dynamic itinerary;
//   String? imageUrl;
//   String? imageBannerUrl;

//   FacilitatorCourses({
//     this.id,
//     this.title,
//     this.slug,
//     this.content,
//     this.imageId,
//     this.bannerImageId,
//     this.shortDesc,
//     this.categoryId,
//     this.isFeatured,
//     this.gallery,
//     this.video,
//     this.price,
//     this.salePrice,
//     this.duration,
//     this.faqs,
//     this.status,
//     this.publishDate,
//     this.createUser,
//     this.updateUser,
//     this.deletedAt,
//     this.views,
//     this.createdAt,
//     this.updatedAt,
//     this.defaultState,
//     this.reviewScore,
//     this.include,
//     this.exclude,
//     this.itinerary,
//     this.imageUrl,
//     this.imageBannerUrl,
//   });

//   FacilitatorCourses.fromJson(Map<String, dynamic> json) {
//     id = json['id'] as String?;
//     title = json['title'] as String?;
//     slug = json['slug'] as String?;
//     content = json['content'] as String?;
//     imageId = json['imageId'] as int?;
//     bannerImageId = json['bannerImageId'] as int?;
//     shortDesc = json['shortDesc'] as String?;
//     categoryId = json['categoryId'] as int?;
//     isFeatured = json['isFeatured'] as int?;
//     gallery = json['gallery'] as String?;
//     video = json['video'] as String?;
//     price = json['price'] as String?;
//     salePrice = json['salePrice'] as String?;
//     duration = json['duration'] as int?;
//     faqs = json['faqs'];
//     status = json['status'] as String?;
//     publishDate = json['publishDate'];
//     createUser = json['createUser'] as String?;
//     updateUser = json['updateUser'];
//     deletedAt = json['deletedAt'];
//     views = json['views'];
//     createdAt = json['createdAt'] as String?;
//     updatedAt = json['updatedAt'];
//     defaultState = json['defaultState'] as int?;
//     reviewScore = json['reviewScore'];
//     include = json['include'];
//     exclude = json['exclude'];
//     itinerary = json['itinerary'];
//     imageUrl = json['imageUrl'] as String?;
//     imageBannerUrl = json['imageBannerUrl'] as String?;
//   }
// }
