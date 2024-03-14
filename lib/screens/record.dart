import 'package:flutter/material.dart';

class RecordSale extends StatelessWidget {
  final TextEditingController itemController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  RecordSale({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Record Sold Item'),
      ),
      body: Column(
        children: [
          TextField(
            controller: itemController,
            decoration: const InputDecoration(
              labelText: 'Item',
            ),
          ),
          TextField(
            controller: quantityController,
            decoration: const InputDecoration(
              labelText: 'Quantity',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final String item = itemController.text;
              final int quantity = int.tryParse(quantityController.text) ?? 0;
              // TODO: Add logic to handle the entered item and quantity
            },
            child: Text('Record Sale'),
          ),
        ],
      ),
    );
  }
}
