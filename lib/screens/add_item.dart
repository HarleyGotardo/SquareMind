import 'package:android_mims_development/services/item_database_helper.dart';
import 'package:flutter/material.dart';

class AddItemPage extends StatefulWidget {
  final String email;
  const AddItemPage({super.key, required this.email});

  @override
  // ignore: library_private_types_in_public_api
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  late ItemDatabaseHelper db;
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _item = {};

  @override
  void initState() {
    super.initState();
    db = ItemDatabaseHelper(userEmailOrNumber: widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Item')),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Item Name'),
              onSaved: (value) => _item['itemName'] = value,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Quantity'),
              onSaved: (value) => _item['quantity'] = value,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Price'),
              onSaved: (value) => _item['price'] = value,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Expiry Date'),
              onSaved: (value) => _item['expiryDate'] = value,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Barcode'),
              onSaved: (value) => _item['barCode'] = value,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Category'),
              onSaved: (value) => _item['category'] = value,
            ),
            // Add more TextFormFields for the other item fields...
            ElevatedButton(
              child: const Text('Save'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  db.addItem(_item);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
