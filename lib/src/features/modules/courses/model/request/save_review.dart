class SaveReviewRequest {
  final String? reviewerRating;
  final String? reviewerComment;
  final String? courseId;
  final String? title;

  SaveReviewRequest({
    this.reviewerRating,
    this.reviewerComment,
    this.courseId,
    this.title,
  });

  SaveReviewRequest.fromJson(Map<String, dynamic> json)
      : reviewerRating = json['reviewerRating'] as String?,
        reviewerComment = json['reviewerComment'] as String?,
        courseId = json['courseId'] as String?,
        title = json['title'] as String?;

  Map<String, dynamic> toJson() => {
    'reviewerRating' : reviewerRating,
    'reviewerComment' : reviewerComment,
    'courseId' : courseId,
    'title' : title
  };
}