import 'package:birds_learning_network/src/features/modules/courses/model/response/db_course_model.dart';
import 'package:birds_learning_network/src/utils/global_constants/database/course_sql.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class CourseDatabase{
  static final CourseDatabase instance = CourseDatabase._init();
  CourseDatabase._init();

  static Database? _database;
  static const int _version = 1;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB("course.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    var directory = await getDatabasesPath();
    String path = p.join(directory.toString(), filePath);

    return await openDatabase(path, version: _version, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    // LoginResponse userData = await UserSecureStorage().getUserData();
    // return await db.execute(CourseSql.createCourseSql());
  }

  Future<bool> doesTableExist(String tableName) async {
    final db = await instance.database;
    List<Map<String, dynamic>> result = await db.query(
      'sqlite_master',
      where: 'type = ? AND name = ?',
      whereArgs: ['table', tableName],
    );
    return result.isNotEmpty;
  }

  Future<void> createTable(String tableName) async {
    final db = await instance.database;
    bool tableExists = await doesTableExist(tableName);
    if (tableExists) {
      // Table exists, perform operations
    } else {
      // Table doesn't exist, create it
      await db.execute(CourseSql.createCourseSql(tableName));
    }
  }

  Future<void> insertCourse(String tableName, CourseModel course) async {
    final db = await instance.database;
    bool courseExists = await doesCourseExist(tableName, course);
    if(courseExists){
      // updateLessonProgress(tableName, course );
    }else{
      await db.insert(
        tableName,
        course.toMap(), // Convert your CourseModel to a map of values
        conflictAlgorithm: ConflictAlgorithm.ignore, // or use other conflict algorithms
      );
    }
  }

  Future<void> updateLessonProgress(String tableName, CourseModel course) async {
    final db = await instance.database;
    await db.update(
      tableName,
      {
        'lessonLastPlayedDuration': course.lessonLastPlayedDuration,
        'progress': course.progress,
      },
      where: 'sectionId = ? AND lessonId = ?', // Specify the condition
      whereArgs: [course.sectionId, course.lessonId],
    );
  }

  Future<bool> doesCourseExist(String table, CourseModel lesson) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(
      table,
      where: 'sectionId = ? AND lessonId = ?',
      whereArgs: [lesson.sectionId, lesson.lessonId],
    );

    return maps.isNotEmpty; // If the query result is not empty, the record exists
  }

  Future<List<CourseModel>> getCourseLessons(String tableName) async {
    final db = await instance.database;

    final List<Map<String, dynamic>> maps = await db.query(tableName);

    return List.generate(maps.length, (i) {
      return CourseModel(
        id: maps[i]['id'],
        sectionId: maps[i]['sectionId'],
        lessonId: maps[i]['lessonId'],
        lessonUrl: maps[i]['lessonUrl'],
        lessonDuration: maps[i]['lessonDuration'],
        lessonTitle: maps[i]['lessonTitle'],
        lessonLastPlayedDuration: maps[i]['lessonLastPlayedDuration'],
        progress: maps[i]['progress'],
      );
    });
  }

  Future<List<CourseModel>> getCoursesBySection(String tableName, sectionId) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      tableName,
      where: 'sectionId = ?',
      whereArgs: [sectionId],
    );
    return List.generate(maps.length, (i) {
      return CourseModel(
        id: maps[i]['id'],
        sectionId: maps[i]['sectionId'],
        lessonId: maps[i]['lessonId'],
        lessonUrl: maps[i]['lessonUrl'],
        lessonDuration: maps[i]['lessonDuration'],
        lessonTitle: maps[i]['lessonTitle'],
        lessonLastPlayedDuration: maps[i]['lessonLastPlayedDuration'],
        progress: maps[i]['progress'],
      );
    });
  }
}