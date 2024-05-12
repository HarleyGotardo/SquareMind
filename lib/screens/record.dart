import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:android_mims_development/services/sales_database_helper.dart';
import 'package:android_mims_development/services/item_database_helper.dart';

class RecordSale extends StatefulWidget {
  final String email;
  RecordSale({Key? key, required this.email}) : super(key: key);

  @override
  _RecordSaleState createState() => _RecordSaleState();
}

class _RecordSaleState extends State<RecordSale> {
  final TextEditingController itemController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController _date = TextEditingController();
  late SaleDatabaseHelper saleDb = SaleDatabaseHelper(userEmailOrNumber: widget.email, itemDbHelper: itemDb);
  late ItemDatabaseHelper itemDb = ItemDatabaseHelper(userEmailOrNumber: widget.email);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.list), // This is the record icon
            SizedBox(width: 8), // This adds some spacing between the icon and the text
            Text(
              'Sales Record',
              style: TextStyle(
              fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: itemController,
                decoration: const InputDecoration(
                  labelText: 'Item',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.inventory),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the item';
                  }
                  return null;
                },
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the quantity';
                  }
                  int? quantity = int.tryParse(value);
                  if (quantity == null || quantity <= 0) {
                    return 'Please enter a positive number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _date,
                decoration: const InputDecoration(
                  labelText: 'Date',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_month),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      _date.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  final String item = itemController.text;
                  final int inputQuantity = int.tryParse(quantityController.text) ?? 0;
                  final DateTime date = DateTime.parse(_date.text);
                  bool itemExists = await itemDb.itemExists(item);

                  if (!itemExists) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Item does not exist'),
                          content: const Text('Please add the item to the inventory first'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                    return; // Return here to avoid proceeding further
                  }

                  // Check if the quantity is sufficient
                  int itemQuantity = await itemDb.getItemQuantity(item);
                  if (itemQuantity - inputQuantity < 0) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Insufficient quantity'),
                          content: const Text('The quantity you entered is more than the available quantity. Please enter a smaller quantity.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                    return; // Return here to avoid proceeding further
                  }

                  // Create a sale item
                  final Map<String, dynamic> saleItem = {
                    'itemName': item,
                    'quantity': inputQuantity,
                    'date': date.toIso8601String(), // assuming the date is stored as a string
                    // add other fields as necessary
                  };

                  try {
                    // Add the sale item to the database
                    await saleDb.addSaleItem(saleItem);
                    await itemDb.checkAndDeleteIfZeroQuantity(item);
                    setState(() {}); // Call setState to refresh the UI
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Item recorded successfully'),
                          content: const Text('The item has been recorded successfully.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } catch (error) {
                    print('Error adding sale item: $error');
                    // Handle error here
                  }
                },
                child: Text('Record Sale'),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: saleDb.getSaleItems(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final item = snapshot.data![index];
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Item Name: ${item['itemName']}'),
                                  Text('Quantity: ${item['quantity']}'),
                                  Text('Date: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(item['date']))}'),
                                  Text('Total: ₱${item['totalPrice']}'),
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
      ),
    );
  }
}