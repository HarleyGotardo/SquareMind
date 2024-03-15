import 'package:android_mims_development/screens/add_item.dart';
import 'package:android_mims_development/screens/edit_item.dart';
import 'package:android_mims_development/services/item_database_helper.dart';
import 'package:flutter/material.dart';

class InventoryPage extends StatefulWidget {
  final String email;
  const InventoryPage({super.key, required this.email});

  @override
  // ignore: library_private_types_in_public_api
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  late ItemDatabaseHelper db;
  late Future<List<Map<String, dynamic>>> items;
  List<Map<String, dynamic>> filteredItems = [];

  @override
  void initState() {
    super.initState();
    db = ItemDatabaseHelper(userEmailOrNumber: widget.email);
    items = db.getItems();
  }

  //method to delete item
  void deleteItem(BuildContext context, Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Item'),
        content: const Text('Are you sure you want to delete this item?'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text('Delete'),
            onPressed: () {
              db.deleteItem(item['id']);
              setState(() {
                items = db.getItems();
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  // method to edit item
  void editItem(BuildContext context, Map<String, dynamic> item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditItemPage(
          email: widget.email,
          item: item,
        ),
      ),
    ).then((value) {
      if (value != null && value) {
        setState(() {
          items = db.getItems();
        });
      }
    });
  }

  void showItemInfo(BuildContext context, Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Item Information'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${item['itemName']}'),
            Text('Quantity: ${item['quantity']}'),
            Text('Price: ${item['price']}'),
            Text('Expiry Date: ${item['expiryDate']}'),
            Text('Category: ${item['category']}'),
            // Add more Text widgets here for other item properties
          ],
        ),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.storefront, size: 32.0),
                SizedBox(width: 8.0),
                Text(
                  'Inventory Management',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            TextField(
              onChanged: (value) async {
                final itemList = await items;
                setState(() {
                  filteredItems = itemList.where((item) {
                    final itemName = item['itemName'].toString().toLowerCase();
                    final searchQuery = value.toLowerCase();
                    return itemName.contains(searchQuery);
                  }).toList();
                });
              },
              decoration: const InputDecoration(
                labelText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: items,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    final itemList = filteredItems.isNotEmpty
                        ? filteredItems
                        : snapshot.data!;
                    return GridView.builder(
                      itemCount: itemList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.0,
                      ),
                      itemBuilder: (context, index) {
                        var item = itemList[index];
                        return GestureDetector(
                          onTap: () => showItemInfo(context, item),
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Options'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      leading: const Icon(Icons.edit),
                                      title: const Text('Edit'),
                                      onTap: () {
                                        Navigator.pop(context);
                                        editItem(context, item);
                                      },
                                    ),
                                    ListTile(
                                      leading: const Icon(Icons.delete),
                                      title: const Text('Delete'),
                                      onTap: () {
                                        Navigator.pop(context);
                                        deleteItem(context, item);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: Card(
                            color: const Color.fromARGB(140, 63, 61, 60),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.inventory,
                                  size: 48.0, // Increase the size to 48.0
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 8.0),
                                Text(
                                  item['itemName'], // Display the item name
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddItemPage(
                      email: widget.email,
                      item: const {},
                    )),
          ).then((value) {
            if (value != null && value) {
              setState(() {
                items = db.getItems();
              });
            }
          });
        }, // The "+" icon
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        child: const Icon(Icons.add),
      ),
    );
  }
}
