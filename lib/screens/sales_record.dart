import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:android_mims_development/screens/record.dart';

class SalesRecord {
  final DateTime date;
  final String itemName;
  final int quantity;
  final double price;

  SalesRecord({
    required this.date,
    required this.itemName,
    required this.quantity,
    required this.price,
  });
}

class SalesRecordPage extends StatefulWidget {
  SalesRecordPage({Key? key}) : super(key: key);

  @override
  _SalesRecordPageState createState() => _SalesRecordPageState();
}

class _SalesRecordPageState extends State<SalesRecordPage> {
  final List<SalesRecord> salesRecords = [
    SalesRecord(
        date: DateTime.now(), itemName: 'Item 1', quantity: 2, price: 100.0),
    SalesRecord(
        date: DateTime.now(), itemName: 'Item 2', quantity: 1, price: 50.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Center(
          child: Row(
            children: [
              Icon(Icons.sell, size: 32.0),
              SizedBox(width: 8.0),
              Text(
                'Sales Record',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                // Navigate to the page to record a sold item
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RecordSale()),
                );
              },
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 63, 61, 60)),
              ),
              child: const Text('Record a Sold Item'),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: SingleChildScrollView(
                child: DataTable(
                  columnSpacing: 12.0,
                  columns: const <DataColumn>[
                    DataColumn(
                      label: SizedBox(
                        width: 100.0, // LIMIT THE WIDTH OF THE COLUMN
                        child: Text(
                          'Item Name',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 80.0, // LIMIT THE WIDTH OF THE COLUMN
                        child: Text(
                          'Date',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 60.0, // LIMIT THE WIDTH OF THE COLUMN
                        child: Text(
                          'Quantity',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: SizedBox(
                        width: 60.0, // LIMIT THE WIDTH OF THE COLUMN
                        child: Text(
                          'Price',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                  ],
                  rows: salesRecords.map((record) {
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(SizedBox(
                            width: 100.0, child: Text(record.itemName))),
                        DataCell(SizedBox(
                            width: 80.0,
                            child: Text(
                                DateFormat('yyyy-MM-dd').format(record.date)))),
                        DataCell(SizedBox(
                            width: 60.0,
                            child: Text(record.quantity.toString()))),
                        DataCell(SizedBox(
                            width: 60.0,
                            child: Text(record.price.toStringAsFixed(2)))),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}