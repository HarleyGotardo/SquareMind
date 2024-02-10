import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../model/user_model.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Users.db";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE User(number TEXT NOT NULL, username TEXT NOT NULL PRIMARY KEY, password TEXT NOT NULL);"),
        version: _version);
  }

  static Future<int> addUser(User user) async {
    final db = await _getDB();
    return await db.insert("User", user.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateUser(User user) async {
    final db = await _getDB();
    return await db.update("User", user.toJson(),
        where: 'username = ?',
        whereArgs: [user.username],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> deleteUser(User user) async {
    final db = await _getDB();
    return await db.update("User", user.toJson(),
        where: 'username = ?', whereArgs: [user.username]);
  }
}
