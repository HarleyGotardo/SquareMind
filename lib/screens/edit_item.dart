import 'package:weirdbuggames_quickstock/services/item_database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditItemPage extends StatefulWidget {
  final Map<String, dynamic> item;
  final String email;

  const EditItemPage({super.key, required this.item, required this.email});

  @override
  _EditItemPageState createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
  late TextEditingController quantityController;
  late TextEditingController priceController;
  ItemDatabaseHelper? db;

  @override
  void initState() {
    super.initState();
    db = ItemDatabaseHelper(userEmailOrNumber: widget.email);
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
                if (quantityController.text.isEmpty ||
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
                  return;
                }

                Map<String, dynamic> updatedItem = {
                  'id': widget.item['id'],
                  'quantity': int.parse(quantityController.text),
                  'price': double.parse(priceController.text),
                };

                await db?.updateItem(updatedItem['id'], updatedItem);
                Navigator.pop(context, true); // Indicate success
              },
            ),
          ],
        ),
      ),
    );
  }
}
