import 'package:notification/models/task_model.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = 'tasks';
  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'tasks.db';

      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) {
          print('creting a new one');
          return db.execute("""
      CREATE TABLE $_tableName(id INTERGER PRIMARYKEY AUTOINCREMENT NOT NULL,title STRING , note TEXT, date STRING , startTime STRING,endTime STRING,remind INTEGER,repeat STRING,color INTERGER,isComplete INTERGER)
""");
        },
      );
    } catch (e) {}
  }
  static Future<int> insert(Task? task) async{
    return await _db?.insert(_tableName, task!.toJson() as Map<String, Object?>)??1;
  }
}
