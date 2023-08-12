import 'package:birds_learning_network/src/features/modules/courses/model/repository/course_database.dart';
import 'package:birds_learning_network/src/features/modules/courses/model/response/db_course_model.dart';
import 'package:birds_learning_network/src/features/modules/home/model/response_model/get_courses.dart';
import 'package:birds_learning_network/src/utils/global_constants/database/course_sql.dart';

Future<List<List<CourseModel>>> getSectionLessons(String courseId, List<Sections> sections)async{
  List<List<CourseModel>> courseSections = [];
  String tableName = await CourseSql.getTableName(courseId);
  for (var section in sections){
    List<CourseModel> lessons = await CourseDatabase.instance.getCoursesBySection(tableName, section.id);
    courseSections.add(lessons);
  }
  return courseSections;
}