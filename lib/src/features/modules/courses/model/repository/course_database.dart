import 'package:birds_learning_network/src/features/modules/courses/model/response/db_course_model.dart';
import 'package:birds_learning_network/src/utils/global_constants/database/course_sql.dart';
import 'package:sqflite/sqflite.dart';

class CourseDatabase{
  static final CourseDatabase instance = CourseDatabase._init();
  CourseDatabase._init();

  static Database? _database;
  static const int _version = 1;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB("product.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    String path = '${await getDatabasesPath()}$filePath';

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
    await db.insert(
      tableName,
      course.toMap(), // Convert your CourseModel to a map of values
      conflictAlgorithm: ConflictAlgorithm.ignore, // or use other conflict algorithms

    );
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