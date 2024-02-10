import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  // Define the colors based on the 60-30-10 rule
  static const Color dominantColor = Color.fromARGB(255, 177, 172, 166); // Dominant color (60%)
  static const Color secondaryColor = Color.fromARGB(255, 63, 61, 60); // Secondary color (30%)
  static const Color accentColor = Color.fromARGB(255, 94, 82, 85); // Accent color (10%)

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quick Stock',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white, // Text color (black)
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: secondaryColor, // Secondary color
        centerTitle: true, // Aligns title to center
      ),
      backgroundColor: dominantColor, // Dominant color
      body: _getPage(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.dashboard,
            ),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.inventory,
            ),
            label: 'Inventory',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.note,
            ),
            label: 'Sales Record',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.cloud,
            ),
            label: 'Cloud',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: dominantColor, // Accent color (highlight color)
        unselectedItemColor: Colors.white, // Secondary color
        onTap: _onItemTapped,
        backgroundColor: secondaryColor, // Dominant color
        type: BottomNavigationBarType.fixed, // Ensures all labels are visible
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return const DashboardPage();
      case 1:
        return InventoryPage();
      case 2:
        return SalesRecordPage();
      case 3:
        return const CloudPage();
      default:
        return Container();
    }
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

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
                Icon(Icons.dashboard, size: 32.0),
                SizedBox(width: 8.0),
                Text(
                  'Dashboard',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: const [
                  Card(
                    child: Center(child: Text('Card 1')),
                  ),
                  Card(
                    child: Center(child: Text('Card 2')),
                  ),
                  Card(
                    child: Center(child: Text('Card 3')),
                  ),
                  Card(
                    child: Center(child: Text('Card 4')),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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

class SalesRecordPage extends StatelessWidget {
  SalesRecordPage({Key? key}) : super(key: key);

  final List<SalesRecord> salesRecords = [
    SalesRecord(date: DateTime.now(), itemName: 'Item 1', quantity: 2, price: 100.0),
    SalesRecord(date: DateTime.now(), itemName: 'Item 2', quantity: 1, price: 50.0),
    // Add more sales records here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Expanded(
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
              },
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
        DataCell(SizedBox(width: 100.0, child: Text(record.itemName))),
        DataCell(SizedBox(width: 80.0, child: Text(DateFormat('yyyy-MM-dd').format(record.date)))),
        DataCell(SizedBox(width: 60.0, child: Text(record.quantity.toString()))),
        DataCell(SizedBox(width: 60.0, child: Text(record.price.toStringAsFixed(2)))),
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

class CloudPage extends StatelessWidget {
  const CloudPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.cloud),
                  SizedBox(width: 8.0),
                  Text(
                    'Cloud Integration',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}