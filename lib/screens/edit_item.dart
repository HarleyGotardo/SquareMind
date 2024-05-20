import 'package:android_mims_development/services/item_database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.text_fields),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: quantityController,
              decoration: const InputDecoration(
                labelText: 'Quantity',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.format_list_numbered),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a quantity';
                }
                final quantity = int.tryParse(value);
                if (quantity == null || quantity <= 0) {
                  return 'Please enter a positive integer';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: priceController,
              decoration: const InputDecoration(
                labelText: 'Price',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.attach_money),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a price';
                }
                final price = double.tryParse(value);
                if (price == null || price <= 0) {
                  return 'Please enter a positive number';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 10),
            const SizedBox(height: 10),
            ElevatedButton(
              child: const Text('Save'),
              onPressed: () async {
                // Check if any input field is empty
                if (nameController.text.isEmpty ||
                    quantityController.text.isEmpty ||
                    priceController.text.isEmpty) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Error'),
                        content: const Text('Please fill in the information of the item'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                  return; // Do not save if any field is empty
                }

                // Create a new map with the updated values
                Map<String, dynamic> updatedItem = {
                  'id': widget.item['id'],
                  'itemName': nameController.text,
                  'quantity': int.parse(quantityController.text),
                  'price': double.parse(priceController.text),
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
