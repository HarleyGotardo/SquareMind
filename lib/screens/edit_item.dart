import 'package:android_mims_development/services/item_database_helper.dart';
import 'package:flutter/material.dart';

class EditItemPage extends StatefulWidget {
  final Map<String, dynamic> item;
  final String email; // Define email property

  const EditItemPage(
      {super.key,
      required this.item,
      required this.email}); // Store email parameter to email property

  @override
  // ignore: library_private_types_in_public_api
  _EditItemPageState createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
  late TextEditingController nameController;
  late TextEditingController quantityController;
  late TextEditingController priceController;
  late TextEditingController expiryDateController;
  late TextEditingController categoryController;
  ItemDatabaseHelper? db;

  @override
  void initState() {
    super.initState();
    db = ItemDatabaseHelper(userEmailOrNumber: widget.email);
    nameController = TextEditingController(text: widget.item['itemName']);
    quantityController =
        TextEditingController(text: widget.item['quantity'].toString());
    priceController =
        TextEditingController(text: widget.item['price'].toString());
    expiryDateController =
        TextEditingController(text: widget.item['expiryDate']);
    categoryController = TextEditingController(text: widget.item['category']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: quantityController,
              decoration: const InputDecoration(labelText: 'Quantity'),
            ),
            TextField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Price'),
            ),
            TextField(
              controller: expiryDateController,
              decoration: const InputDecoration(labelText: 'Expiry Date'),
            ),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: 'Category'),
            ),
            ElevatedButton(
              child: const Text('Save'),
              onPressed: () async {
                // Create a new map with the updated values
                Map<String, dynamic> updatedItem = {
                  'id': widget.item['id'],
                  'itemName': nameController.text,
                  'quantity': int.parse(quantityController.text),
                  'price': double.parse(priceController.text),
                  'expiryDate': expiryDateController.text,
                  'category': categoryController.text,
                };

                // Call the updateItem function
                await db?.updateItem(updatedItem['id'], updatedItem);
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
