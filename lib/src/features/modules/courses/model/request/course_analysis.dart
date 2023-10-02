class CourseAnalysisRequest {
  final dynamic courseId;
  final dynamic lessonId;
  final int? percentageOfLessonCompletion;

  CourseAnalysisRequest({
    this.courseId,
    this.lessonId,
    this.percentageOfLessonCompletion,
  });

  CourseAnalysisRequest.fromJson(Map<String, dynamic> json)
      : courseId = json['courseId'] as int?,
        lessonId = json['lessonId'] as int?,
        percentageOfLessonCompletion = json['percentageOfLessonCompletion'] as int?;

  Map<String, dynamic> toJson() => {
    'courseId' : courseId,
    'lessonId' : lessonId,
    'percentageOfLessonCompletion' : percentageOfLessonCompletion
  };
}