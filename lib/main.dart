import 'package:android_mims_development/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:android_mims_development/screens/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventory and Sales Management System',
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(0, 151, 178, 100),
        hintColor: const Color.fromRGBO(0, 151, 178, 100),
        fontFamily: 'Roboto',
      ),
      home: const MainPage(),
    );
  }
}