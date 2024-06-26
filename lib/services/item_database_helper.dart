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
        price INT
      )
    ''');
  }

  Future<void> addItem(Map<String, dynamic> item) async {
    final db = await database;
    final result = await db.rawQuery('SELECT * FROM Item WHERE LOWER(itemName) = LOWER(?)', [item['itemName']]);
    if (result.isEmpty) {
      await db.insert('Item', item);
    } else {
      throw Exception('Item with this name already exists');
    }
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

  Future<bool> itemExists(String itemName) async {
    final db = await database;
    final result = await db.query('Item', where: 'itemName = ?', whereArgs: [itemName]);
    return result.isNotEmpty;
  }

  Future<void> checkAndDeleteIfZeroQuantity(String itemName) async {
    final db = await database;
    final result = await db.query('Item', where: 'itemName = ?', whereArgs: [itemName]);
    if (result.isNotEmpty) {
      int quantity = int.tryParse(result.first['quantity'] as String) ?? 0;
      if (quantity <= 0) {
        await db.delete('Item', where: 'itemName = ?', whereArgs: [itemName]);
      }
    }
  }

  Future<int> getItemQuantity(String itemName) async {
    final db = await database;
    final result = await db.query('Item', where: 'itemName = ?', whereArgs: [itemName]);
    if (result.isNotEmpty) {
      return int.tryParse(result.first['quantity'] as String) ?? 0;
    }
    return 0;
  }

  Future<double> getItemPrice(String itemName) async {
    final db = await database;
    final result = await db.query('Item', where: 'itemName = ?', whereArgs: [itemName]);
    if (result.isNotEmpty) {
      return (result.first['price'] as int).toDouble();
    }
    return 0.0;
  }

  Future<int> getTotalItemQuantity(String itemName) async {
    final db = await database;
    final result = await db.query('Item', where: 'itemName = ?', whereArgs: [itemName]);

    int totalQuantity = 0;
    for (var item in result) {
      int quantity = int.tryParse(item['quantity'] as String) ?? 0;
      totalQuantity += quantity;
    }

    return totalQuantity;
  }

  Future<Map<String, Map<String, dynamic>>> getAllItemNames() async {
    final db = await database;
    final result = await db.query('Item');

    Map<String, Map<String, dynamic>> items = {};

    for (var item in result) {
      String itemName = item['itemName'].toString();
      int quantity = item['quantity'] as int;
      double price = item['price'] as double;

      items[itemName] = {
        'quantity': quantity,
        'price': price,
      };
    }

    return items;
  }

  Future<List<String>> getAllItemNames2() async {
    final db = await database;
    final result = await db.query('Item');

    List<String> itemNames = [];
    for (var item in result) {
      itemNames.add(item['itemName'].toString());
    }

    return itemNames;
  }

  Future<bool> itemNameExists(String itemName) async {
    final db = await database;
    final result = await db.query('Item', where: 'LOWER(itemName) = LOWER(?)', whereArgs: [itemName]);
    return result.isNotEmpty;
  }
}
