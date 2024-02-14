import 'package:flutter/material.dart';
import 'package:android_mims_development/screens/dashboard.dart';
import 'package:android_mims_development/screens/inventory_management.dart';
import 'package:android_mims_development/screens/sales_record.dart';
import 'package:android_mims_development/screens/cloud_integration.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  // Define the colors based on the 60-30-10 rule
  static const Color dominantColor =
      Color.fromARGB(255, 177, 172, 166); // Dominant color (60%)
  static const Color secondaryColor =
      Color.fromARGB(255, 63, 61, 60); // Secondary color (30%)

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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: secondaryColor,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Profile'),
              onTap: () {
                // TODO: Navigate to Profile
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // TODO: Navigate to Settings
              },
            ),
          ],
        ),
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
        return const InventoryPage();
      case 2:
        return SalesRecordPage();
      case 3:
        return const CloudPage();
      default:
        return Container();
    }
  }
}
