import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ItemDatabaseHelper {
  final String userEmailOrNumber;

  ItemDatabaseHelper({required this.userEmailOrNumber});

  String get _databaseName => 'database_$userEmailOrNumber.db';

  Future<Database> get database async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, _databaseName);

    return openDatabase(path, version: 1, onCreate: _createDb);
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''
      CREATE TABLE Item (
        id INTEGER PRIMARY KEY,
        itemName TEXT,
        quantity TEXT,
        price INT,
        expiryDate TEXT,
        barcode TEXT,
        category TEXT
      )
    ''');
  }

  // Rest of your database methods...
}
