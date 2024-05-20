import 'package:android_mims_development/services/item_database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AddItemPage extends StatefulWidget {
  final String email;
  const AddItemPage({super.key, required this.email, required Map<String, dynamic> item});

  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  late ItemDatabaseHelper db;
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _item = {};
  final TextEditingController _date = TextEditingController();

  @override
  void initState() {
    super.initState();
    db = ItemDatabaseHelper(userEmailOrNumber: widget.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: const Row(
        children: [
        Icon(Icons.add_shopping_cart),
        Text('Add Item', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Item Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.shopping_bag),
                ),
                onSaved: (value) => _item['itemName'] = value,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the item name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Quantity',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.format_list_numbered),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                onSaved: (value) => _item['quantity'] = int.parse(value!),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the quantity';
                  } else if (int.tryParse(value) == null || int.parse(value) <= 0) {
                    return 'Please enter a positive integer';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.attach_money),
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                ],
                onSaved: (value) => _item['price'] = double.parse(value!),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the price';
                  } else if (double.tryParse(value) == null || double.parse(value) <= 0) {
                    return 'Please enter a positive number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
   
                      const SizedBox(height: 16.0),
              const SizedBox(height: 16.0),
              // Add more TextFormFields for the other item fields...
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            try {
              await db.addItem(_item);
              Navigator.pop(context);
            } catch (e) {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Duplicate Item Name'),
                  content: const Text('An item with this name already exists.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            }
          } else {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Incomplete Information'),
                content: const Text('Please fill in all the fields.'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}