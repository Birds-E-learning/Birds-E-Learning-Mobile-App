class GetReviewResponse {
  final String? responseCode;
  final String? responseMessage;
  final ResponseData? responseData;

  GetReviewResponse({
    this.responseCode,
    this.responseMessage,
    this.responseData,
  });

  GetReviewResponse.fromJson(Map<String, dynamic> json)
      : responseCode = json['responseCode'] as String?,
        responseMessage = json['responseMessage'] as String?,
        responseData = (json['responseData'] as Map<String,dynamic>?) != null ? ResponseData.fromJson(json['responseData'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'responseCode' : responseCode,
    'responseMessage' : responseMessage,
    'responseData' : responseData?.toJson()
  };
}

class ResponseData {
  final dynamic totalReviewers;
  final List<Reviews>? reviews;

  ResponseData({
    this.totalReviewers,
    this.reviews,
  });

  ResponseData.fromJson(Map<String, dynamic> json)
      : totalReviewers = json['totalReviewers'] as dynamic,
        reviews = (json['reviews'] as List?)?.map((dynamic e) => Reviews.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'totalReviewers' : totalReviewers,
    'reviews' : reviews?.map((e) => e.toJson()).toList()
  };
}

class Reviews {
  final String? reviewerName;
  final dynamic reviewerRating;
  final String? reviewerComment;
  final String? dateOfReview;
  final String? reviewerImage;

  Reviews({
    this.reviewerName,
    this.reviewerRating,
    this.reviewerComment,
    this.dateOfReview,
    this.reviewerImage,
  });

  Reviews.fromJson(Map<String, dynamic> json)
      : reviewerName = json['reviewerName'] as String?,
        reviewerRating = json['reviewerRating'] as dynamic,
        reviewerComment = json['reviewerComment'] as String?,
        dateOfReview = json['dateOfReview'] as String?,
        reviewerImage = json['reviewerImage'] as String?;

  Map<String, dynamic> toJson() => {
    'reviewerName' : reviewerName,
    'reviewerRating' : reviewerRating,
    'reviewerComment' : reviewerComment,
    'dateOfReview' : dateOfReview,
    'reviewerImage' : reviewerImage
  };
}