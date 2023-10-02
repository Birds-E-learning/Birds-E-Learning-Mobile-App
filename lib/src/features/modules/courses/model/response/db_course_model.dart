class CourseModel {
  final dynamic id;
  final String? sectionId;
  final String? lessonId;
  final String? lessonUrl;
  final dynamic lessonDuration;
  final String? lessonTitle;
   dynamic lessonLastPlayedDuration;
   dynamic progress;
   bool? pauseVideo;

  CourseModel({
     this.id,
     this.sectionId,
     this.lessonId,
     this.lessonUrl,
     this.lessonDuration,
     this.lessonTitle,
     this.lessonLastPlayedDuration,
     this.progress,
     this.pauseVideo,
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



