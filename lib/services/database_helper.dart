import 'dart:async';
import 'package:android_mims_development/model/user_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A helper class for managing the SQLite database.
class DatabaseHelper {
  static const _databaseName = "User.db";
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

  /// Returns the instance of the database.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  Future _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  /// Creates the user table when the database is created.
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnEmailOrNumber TEXT NOT NULL,
            $columnUsername TEXT NOT NULL,
            $columnPassword TEXT NOT NULL
          )
          ''');
  }

  Future<void> loginUser(String username, String password) async {
    // Check if the username and password are valid
    bool isValid = await checkLogin(username, password);

    if (isValid) {
      // If login is successful, save the login status
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('username', username);
    } else {
      throw Exception('Invalid username or password');
    }
  }

  void logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
  }

  // Helper methods
  /// Inserts a user into the database.
  Future<int> insert(User user) async {
    Database db = await instance.database;
    return await db.insert(table, user.toJson());
  }

  /// Retrieves all users from the database.
  Future<List<User>> queryAllRows() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(table);

    return List.generate(maps.length, (i) {
      return User.fromMap(maps[i]);
    });
  }

  /// Deletes a user from the database based on the email or number.
  Future<int> delete(String emailOrNumber) async {
    Database db = await instance.database;
    return await db.delete(table,
        where: '$columnEmailOrNumber = ?', whereArgs: [emailOrNumber]);
  }

  /// Checks if an email or number exists in the database.
  Future<bool> emailOrNumberExists(String emailOrNumber) async {
    final db = await database;
    var result = await db
        .query("User", where: "emailOrNumber = ?", whereArgs: [emailOrNumber]);
    return result.isNotEmpty;
  }

  /// Checks if a username and password combination is valid for login.
  Future<bool> checkLogin(String username, String password) async {
    final db = await database;
    var result = await db.query("User",
        where: "username = ? AND password = ?",
        whereArgs: [username, password]);
    return result.isNotEmpty;
  }

  Future<Object?> getUserEmail(String username) async {
    final db = await database;
    var result =
        await db.query("User", where: "username = ?", whereArgs: [username]);
    if (result.isNotEmpty) {
      return result.first['emailOrNumber']; // Accessing the 'email' column
    } else {
      throw Exception('User not found');
    }
  }

Future<String?> getUsername(String emailOrNumber) async {
  final db = await database;
  var result = await db.query(table, where: "$columnEmailOrNumber = ?", whereArgs: [emailOrNumber]);
  if (result.isNotEmpty) {
    return result.first[columnUsername] as String; // Accessing the 'username' column
  } else {
    throw Exception('User not found');
  }
}

  /// Clears the entire database.
  Future<void> clearDatabase() async {
    final db = await database;
    await db.close(); // Close the database

    // Delete the database
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, '_databaseName.db');
    await deleteDatabase(path);

    // Recreate the database
    _database = await _initDatabase();
  }

Future<Map<String, String>> getUserCredentials() async {
  final db = await database;
  var result = await db.query(table, limit: 1);
  if (result.isNotEmpty) {
    return {
      'email': result.first[columnEmailOrNumber] as String,
      'password': result.first[columnPassword] as String,
    };
  } else {
    throw Exception('User not found');
  }
}

}
