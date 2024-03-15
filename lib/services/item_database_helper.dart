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

  Future<void> addItem(Map<String, dynamic> item) async {
    final db = await database;
    await db.insert('Item', item);
  }

  Future<List<Map<String, dynamic>>> getItems() async {
    final db = await database;
    return await db.query('Item');
  }

  Future<void> deleteItem(int id) async {
    final db = await database;
    await db.delete('Item', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> updateItem(int id, Map<String, dynamic> newItem) async {
    final db = await database;
    await db.update('Item', newItem, where: 'id = ?', whereArgs: [id]);
  }
}
