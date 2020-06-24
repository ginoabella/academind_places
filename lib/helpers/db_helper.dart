import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class DbHelper {
  static Future<Database> database(String table) async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'places1.db'),
        onCreate: (db, version) async {
      return await db.execute('''
          CREATE TABLE $table (
            id TEXT PRIMARY KEY,
            title TEXT,
            image TEXT,
            loc_lat REAL,
            loc_lng REAL,
            address TEXT
          )
        ''');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DbHelper.database(table);

    db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, Object>>> getData(String table) async {
    final db = await DbHelper.database(table);
    return db.query(table);
  }
}
