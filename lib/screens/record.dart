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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Record Sold Item'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: itemController,
              decoration: const InputDecoration(
                labelText: 'Item',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.inventory),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: quantityController,
              decoration: const InputDecoration(
                labelText: 'Quantity',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.format_list_numbered),
              ),
              keyboardType: TextInputType.number,
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
                final String item = itemController.text;
                final int inputQuantity = int.tryParse(quantityController.text) ?? 0;
                final DateTime date = DateTime.parse(_date.text);
                bool itemExists = await itemDb.itemExists(item);

                if (!itemExists) {
                  return showDialog(
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
                }

                // Check if the quantity is sufficient
                int itemQuantity = await itemDb.getItemQuantity(item);
                if (itemQuantity - inputQuantity < 0) {
                  return showDialog(
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
                }

                // Create a sale item
                final Map<String, dynamic> saleItem = {
                  'itemName': item,
                  'quantity': inputQuantity,
                  'date': date.toIso8601String(), // assuming the date is stored as a string
                  // add other fields as necessary
                };

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
                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text('Item Name')),
                            DataColumn(label: Text('Quantity')),
                            DataColumn(label: Text('Date')),
                          ],
                          rows: snapshot.data!.map((item) {
                            return DataRow(cells: [
                              DataCell(Text(item['itemName'].toString())),
                              DataCell(Text(item['quantity'].toString())),
                              DataCell(Text(DateFormat('yyyy-MM-dd').format(DateTime.parse(item['date'])))),
                            ]);
                          }).toList(),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}