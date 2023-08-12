import 'package:birds_learning_network/src/features/modules/courses/model/repository/course_database.dart';
import 'package:birds_learning_network/src/features/modules/courses/model/response/db_course_model.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/utils/global_constants/database/course_sql.dart';

Future<void> insertDatabaseCourse(Courses course) async{
  if(course.sections != null){
    String tableName = await CourseSql.getTableName("${course.id ?? 0}");
    for (var section in course.sections!){
      if(section.lessons != null){
        for (var lesson in section.lessons!){
          CourseModel data = CourseModel(
            sectionId: section.id.toString(),
            lessonId: lesson.id.toString(),
            lessonUrl: lesson.url,
            lessonTitle: lesson.name,
            lessonDuration: lesson.duration,
            lessonLastPlayedDuration: 0,
            progress: lesson.progress ?? 0
          );
         await CourseDatabase.instance.insertCourse(tableName, data);
        }
      }
    }
  }
}