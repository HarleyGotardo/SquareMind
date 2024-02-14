import 'dart:async';
import 'package:android_mims_development/model/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = "MyDatabase.db";
  static const _databaseVersion = 1;

  static const table = 'user';

  static const columnEmailOrNumber = 'emailOrNumber';
  static const columnUsername = 'username';
  static const columnPassword = 'password';

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnEmailOrNumber TEXT NOT NULL,
            $columnUsername TEXT NOT NULL,
            $columnPassword TEXT NOT NULL
          )
          ''');
  }

  // Helper methods

  Future<int> insert(User user) async {
    Database db = await instance.database;
    return await db.insert(table, user.toJson());
  }

  Future<List<User>> queryAllRows() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(table);

    return List.generate(maps.length, (i) {
      return User.fromMap(maps[i]);
    });
  }

  Future<int> delete(String emailOrNumber) async {
    Database db = await instance.database;
    return await db.delete(table,
        where: '$columnEmailOrNumber = ?', whereArgs: [emailOrNumber]);
  }

  Future<bool> emailOrNumberExists(String emailOrNumber) async {
    final db = await database;
    var result = await db
        .query("User", where: "emailOrNumber = ?", whereArgs: [emailOrNumber]);
    return result.isNotEmpty;
  }
}
