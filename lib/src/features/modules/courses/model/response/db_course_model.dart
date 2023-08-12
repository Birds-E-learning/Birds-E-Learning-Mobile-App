class CourseModel {
  final int? id;
  final String? sectionId;
  final String? lessonId;
  final String? lessonUrl;
  final dynamic lessonDuration;
  final String? lessonTitle;
  final dynamic lessonLastPlayedDuration;
  final double? progress;

  CourseModel({
     this.id,
     this.sectionId,
     this.lessonId,
     this.lessonUrl,
     this.lessonDuration,
     this.lessonTitle,
     this.lessonLastPlayedDuration,
     this.progress,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sectionId': sectionId,
      'lessonId': lessonId,
      'lessonUrl': lessonUrl,
      'lessonDuration': lessonDuration,
      'lessonTitle': lessonTitle,
      'lessonLastPlayedDuration': lessonLastPlayedDuration,
      'progress': progress,
    };
  }
}



