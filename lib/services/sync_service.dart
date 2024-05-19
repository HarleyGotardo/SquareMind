import 'package:firebase_database/firebase_database.dart';
import 'package:android_mims_development/services/item_database_helper.dart';
import 'package:android_mims_development/services/sales_database_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SyncService {
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;
  final String userEmail;
  final ItemDatabaseHelper itemDbHelper;
  final SaleDatabaseHelper saleDbHelper;

  SyncService({
    required User user,
    required this.itemDbHelper,
    required this.saleDbHelper,
  }) : userEmail = user.email ?? '';

  DatabaseReference get _userRef => _firebaseDatabase.ref().child(userEmail);

  Future<void> syncToFirebase() async {
    try {
      // Get items and sales data
      Map<String, List<Map<String, dynamic>>> items = (await itemDbHelper.getAllItemNames()).cast<String, List<Map<String, dynamic>>>();
      Map<String, List<Map<String, dynamic>>> sales = await saleDbHelper.getAllSaleItems();

      // Push data to Firebase under user's node
      final userRef = _firebaseDatabase.ref().child(userEmail);
      
      // Convert List<Map<String, dynamic>> to Map<String, List<Map<String, dynamic>>>
      Map<String, List<Map<String, dynamic>>> itemsMap = {};
      for (var entry in items.entries) {
        itemsMap[entry.key] = entry.value;
      }
      
      Map<String, List<Map<String, dynamic>>> salesMap = {};
      for (var entry in sales.entries) {
        salesMap[entry.key] = entry.value;
      }

      await userRef.child('items').set(itemsMap);
      await userRef.child('sales').set(salesMap);

      print('Data synced successfully');
    } catch (e) {
      print('Error during syncToFirebase: $e');
    }
  }

  Future<void> downloadFromFirebase() async {
    try {
      // Download Items
      DataSnapshot itemSnapshot = (await _userRef.child('items').once()).snapshot;
      if (itemSnapshot.value is Map) {
        List<Map<String, dynamic>> items = (itemSnapshot.value as Map).values.cast<Map<String, dynamic>>().toList();
        print('Downloading ${items.length} items from Firebase');
        for (var item in items) {
          await itemDbHelper.addItem(item);
        }
      }

      // Download Sales
      DataSnapshot salesSnapshot = (await _userRef.child('sales').once()).snapshot;
      if (salesSnapshot.value is Map) {
        List<Map<String, dynamic>> sales = (salesSnapshot.value as Map).values.cast<Map<String, dynamic>>().toList();
        print('Downloading ${sales.length} sales from Firebase');
        for (var sale in sales) {
          await saleDbHelper.addSaleItem(sale);
        }
      }

      print('Data downloaded successfully');
    } catch (e) {
      print('Error during downloadFromFirebase: $e');
    }
  }
}