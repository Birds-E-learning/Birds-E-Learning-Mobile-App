import 'package:birds_learning_network/src/features/core/auth/model/response_model/login_response.dart';
import 'package:birds_learning_network/src/global_model/services/storage/secure_storage/user_details.dart';

class CourseSql{


  static Future<String> getTableName(String courseId)async{
    LoginResponse userData = await UserSecureStorage().getUserData();
    String tableName = "User${userData.responseData!.userId}Course$courseId";
    String sanitizedName = tableName.replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '');

    // Make sure the table name starts with a letter or underscore
    if (sanitizedName.isNotEmpty && !RegExp(r'^[a-zA-Z_]').hasMatch(sanitizedName)) {
      sanitizedName = '_$sanitizedName';
    }
    // print("Table name  =======>>> $sanitizedName");
    return sanitizedName;
  }

  static String createCourseSql(String tableName) => '''
  CREATE TABLE IF NOT EXISTS $tableName (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    sectionId TEXT,
    lessonId TEXT,
    lessonUrl TEXT,
    lessonDuration INTEGER,
    lessonTitle TEXT,
    lessonLastPlayedDuration INTEGER,
    progress REAL,
    UNIQUE(sectionId, lessonId)
  )
''';
}