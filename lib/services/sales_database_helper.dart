import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'item_database_helper.dart';
import 'package:intl/intl.dart';

class SaleDatabaseHelper {
  final String userEmailOrNumber;
  final ItemDatabaseHelper itemDbHelper;

  SaleDatabaseHelper({required this.userEmailOrNumber, required this.itemDbHelper});

  String get _databaseName => 'sale_database_$userEmailOrNumber.db';

  Future<Database> get database async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, _databaseName);

    return openDatabase(path, version: 1, onCreate: _createDb);
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''
      CREATE TABLE SaleItem (
        id INTEGER PRIMARY KEY,
        itemName TEXT,
        quantity INT,
        date TEXT,
        totalPrice REAL
      )
    ''');
  }

  Future<void> addSaleItem(Map<String, dynamic> saleItem) async {
    final db = await database;
    
    // Fetch the price of the item
    final itemName = saleItem['itemName'];
    final itemPrice = await itemDbHelper.getItemPrice(itemName);

    // Calculate the total price and add it to the sale item
    final soldQuantity = saleItem['quantity'];
    final totalPrice = itemPrice * soldQuantity;
    saleItem['totalPrice'] = totalPrice;

    await db.insert('SaleItem', saleItem);

    // Update the quantity in the item database
    final items = await itemDbHelper.getItems();
    final item = items.firstWhere((item) => item['itemName'] == itemName);
    final currentQuantity = int.parse(item['quantity'] as String);
    final newQuantity = currentQuantity - soldQuantity;
    await itemDbHelper.updateItem(item['id'], {'quantity': newQuantity.toString()});
  }

  Future<List<Map<String, dynamic>>> getSaleItems() async {
    final db = await database;
    return await db.query('SaleItem');
  }

Future<double> calculateTotalSales() async {
  final db = await database;
  
  // Get the current date as a string in ISO 8601 format, but without the time
  String currentDate = DateTime.now().toIso8601String().substring(0, 10);

  // Get all of the sales items with the current date
  final result = await db.query('SaleItem', where: 'date LIKE ?', whereArgs: ["$currentDate%"]);

  double totalSales = 0.0;
  for (var row in result) {
    var totalPrice = row['totalPrice'];
    if (totalPrice is double) {
      totalSales += totalPrice;
    } else if (totalPrice is int) {
      totalSales += totalPrice.toDouble();
    }
  }
  
  return totalSales;
}
Future<List<Map<String, dynamic>>> getTotalSoldItems() async {
  final db = await database;

  final List<Map<String, dynamic>> maps = await db.rawQuery('''
    SELECT itemName, SUM(quantity) as totalQuantity
    FROM SaleItem
    GROUP BY itemName
  ''');

  return maps;
}
Future<Map<String, double>> getTotalSalesByMonth() async {
  final db = await database;

  // Query the database for all sales items, group them by month, and sum the total sales for each month
  final List<Map<String, dynamic>> result = await db.rawQuery('''
    SELECT strftime('%Y-%m', date) as month, SUM(totalPrice) as totalSales
    FROM SaleItem
    GROUP BY month
  ''');

  // Convert the result into a map where the keys are the months and the values are the total sales
  Map<String, double> totalSalesByMonth = {};
  for (var row in result) {
    String month = row['month'];
    double totalSales = row['totalSales'];
    totalSalesByMonth[month] = totalSales;
  }

  return totalSalesByMonth;
}
}