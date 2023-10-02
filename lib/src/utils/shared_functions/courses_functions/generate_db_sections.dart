import 'package:birds_learning_network/src/features/modules/courses/model/response/db_course_model.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';

Future<List<List<CourseModel>>> getSectionLessons(String courseId, List<Sections> sections)async{
  List<List<CourseModel>> courseSections = [];
  // String tableName = await CourseSql.getTableName(courseId);
  for (var section in sections){
    // List<CourseModel> lessons = await CourseDatabase.instance.getCoursesBySection(tableName, section.id);
    List<CourseModel> courseLessons = [];
    for(Lessons lesson in section.lessons ?? []){
      CourseModel courseModel = CourseModel(
        lessonId: lesson.id,
        lessonLastPlayedDuration: lesson.progress,
        lessonDuration: lesson.duration,
        lessonTitle: lesson.name,
        lessonUrl: lesson.url,
        progress: lesson.progress,
        sectionId: section.id,
      );
      courseLessons.add(courseModel);
    }
    courseSections.add(courseLessons);
  }
  return courseSections;
}