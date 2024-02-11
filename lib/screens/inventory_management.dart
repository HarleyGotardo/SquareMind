import 'package:flutter/material.dart';

class ItemDetailPage extends StatelessWidget {
  final String itemName;
  final String quantity;
  final String price;
  final String expiryDate;
  final String barcode;

  const ItemDetailPage({
    Key? key,
    required this.itemName,
    required this.quantity,
    required this.price,
    required this.expiryDate,
    required this.barcode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(itemName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Quantity: $quantity'),
            Text('Price: $price'),
            Text('Expiry Date: $expiryDate'),
            Text('Barcode: $barcode'),
          ],
        ),
      ),
    );
  }
}

class InventoryPage extends StatelessWidget {
  InventoryPage({Key? key}) : super(key: key);

  final List<Map<String, String>> items = [
    {
      'Item Name': 'Item 1',
      'Quantity': '10',
      'Price': '100.00',
      'Expiry Date': '2022-12-31',
      'Barcode': '1234567890',
    },
    // Add more items here
  ];

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
                Icon(Icons.inventory, size: 32.0),
                SizedBox(width: 8.0),
                Text(
                  'Inventory',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: GridView.builder(
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2, // Change this number to adjust the number of items in a row
    childAspectRatio: 1.0,
  ),
  itemCount: items.length,
  itemBuilder: (context, index) {
    return GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItemDetailPage(
          itemName: items[index]['Item Name']!,
          quantity: items[index]['Quantity']!,
          price: items[index]['Price']!,
          expiryDate: items[index]['Expiry Date']!,
          barcode: items[index]['Barcode']!,
        ),
      ),
    );
  },
      child: Card(
        color: const Color.fromARGB(255, 63, 61, 60), // Change the color of the square
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0), // Add a border radius to the square
        ),
        child: Center(
          child: Text(
            items[index]['Item Name']!,
            style: const TextStyle(fontSize: 24, color: Colors.white), // Change the color of the text
          ),
        ),
      ),
    );
  },
),
            ),
          ],
        ),
      ),
    );
  }
}