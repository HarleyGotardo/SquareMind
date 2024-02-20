import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:android_mims_development/model/item_model.dart';

class DatabaseHelper {
  static const _databaseName = "ItemDatabase.db";
  static const _databaseVersion = 1;

  static const table = 'items';

  static const columnId = '_id';
  static const columnName = 'itemName';
  static const columnQuantity = 'quantity';
  static const columnPrice = 'price';
  static const columnExpiryDate = 'expiryDate';
  static const columnBarcode = 'barcode';
  static const columnCategory = 'category';

  // Singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Database reference
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Open the database and create it if it doesn't exist
  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnName TEXT NOT NULL,
            $columnQuantity TEXT NOT NULL,
            $columnPrice TEXT NOT NULL,
            $columnExpiryDate TEXT NOT NULL,
            $columnBarcode TEXT NOT NULL
            $columnCategory TEXT NOT NULL
          )
          ''');
  }

  // Database operations: insert, query, update, delete

  Future<int> insert(Item item) async {
    Database db = await instance.database;
    return await db.insert(table, item.toJson());
  }

  Future<List<Item>> queryAllRows() async {
    Database db = await instance.database;
    var res = await db.query(table);
    List<Item> list =
        res.isNotEmpty ? res.map((c) => Item.fromMap(c)).toList() : [];
    return list;
  }

  Future<int> update(Item item) async {
    Database db = await instance.database;
    int? id = item.id();
    return await db
        .update(table, item.toJson(), where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
