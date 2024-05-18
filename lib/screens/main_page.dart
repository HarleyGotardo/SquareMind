import 'package:flutter/material.dart';
import 'package:android_mims_development/screens/dashboard.dart';
import 'package:android_mims_development/screens/inventory_management.dart';
import 'package:android_mims_development/screens/record.dart';
import 'package:android_mims_development/screens/cloud_integration.dart';
import 'login_screen.dart';
import 'package:android_mims_development/screens/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:android_mims_development/services/database_helper.dart';
import 'package:android_mims_development/screens/firebase_login.dart';

class MainPage extends StatefulWidget {
  final String email;
  const MainPage({super.key, required this.email});

  @override
  // ignore: library_private_types_in_public_api
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  bool isLoggedIn = false;
  // Define the colors based on the 60-30-10 rule
  static const Color dominantColor =
      Color.fromARGB(255, 177, 172, 166); // Dominant color (60%)
  // static const Color secondaryColor =
  // Color.fromARGB(255, 63, 61, 60); // Secondary color (30%)

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
            fontWeight: FontWeight.normal,
            color: Color.fromARGB(255, 0, 0, 0), // Text color (black)
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: const Color.fromARGB(100, 234, 221, 255),
        centerTitle: true, // Aligns title to center
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(100, 234, 221, 255),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Profile'),
              onTap: () async {
                final DatabaseHelper dbHelper = DatabaseHelper.instance;
                String? username = await dbHelper.getUsername(widget.email);
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(
                        milliseconds: 500), // Set the duration of the animation
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        ProfileScreen(username: username ?? 'default'),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: child,
                      );
                    },
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Confirmation'),
                      content: const Text('Are you sure you want to log out?'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('No'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('Yes'),
                          onPressed: () async{
                            SharedPreferences prefs = await SharedPreferences.getInstance();
await prefs.setBool('isLoggedIn', false);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
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
        selectedItemColor: const Color.fromARGB(
            255, 0, 0, 0), // Accent color (highlight color)
        selectedFontSize: double.parse('15.0'),
        selectedIconTheme: const IconThemeData(size: 30.0),
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedItemColor:
            const Color.fromARGB(255, 0, 0, 0), // Secondary color
        onTap: _onItemTapped,
        backgroundColor:
            const Color.fromARGB(100, 234, 221, 255), // Dominant color
        type: BottomNavigationBarType.fixed, // Ensures all labels are visible
      ),
    );
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return DashboardPage(email: widget.email);
      case 1:
        return InventoryPage(email: widget.email);
      case 2:
        return RecordSale(email: widget.email);
      case 3:
        return CloudPage();
      default:
        return Container();
    }
  }
}
