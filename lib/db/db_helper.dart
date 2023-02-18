import 'package:notification/models/task_model.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 5;
  static const String _tableName = 'task123s';
  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'task123s.db';

      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) {
          print('creting a new one');
          return db.execute("""
      CREATE TABLE $_tableName(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,title STRING , note TEXT,isCompleted INTEGER, date STRING , startDate STRING,endDate STRING,color INTEGER,remind INTEGER,repeat STRING)
""");
        },
      );
    } catch (e) {}
  }

  static Future<int> insert(Task? task) async {
    return await _db?.insert(_tableName, task!.toJson()) ?? 1;
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print('query function called');
    return await _db!.query(_tableName);
  }

  static delete(Task task) async {
    return await _db!.delete(_tableName, where: 'id=?', whereArgs: [task.id]);
  }

  static update(int id) async {
    return await _db!.rawUpdate("""
  UPDATE $_tableName SET isCompleted = ? WHERE id = ?
""", [1, id]);
  }
}
