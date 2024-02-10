import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  // Define the colors based on the 60-30-10 rule
  static const Color dominantColor = Color.fromARGB(255, 255, 253, 255); // Dominant color (60%)
  static const Color secondaryColor = Color.fromARGB(255, 19, 16, 57); // Secondary color (30%)
  static const Color accentColor = Color.fromARGB(255, 80, 191, 160); // Accent color (10%)

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
            color: dominantColor, // Text color (black)
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
        selectedItemColor: accentColor, // Accent color (highlight color)
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
        return const InventoryPage();
      case 2:
        return const SalesRecordPage();
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
    return const Center(
      child: Text('Dashboard Page'),
    );
  }
}

class InventoryPage extends StatelessWidget {
  const InventoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Inventory Management'),
    );
  }
}

class SalesRecordPage extends StatelessWidget {
  const SalesRecordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Sales Record Page'),
    );
  }
}

class CloudPage extends StatelessWidget {
  const CloudPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Cloud Page'),
    );
  }
}
