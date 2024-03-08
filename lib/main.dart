import 'package:android_mims_development/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inventory and Sales Management System',
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 0, 0, 0),
        hintColor: const Color.fromARGB(255, 0, 0, 0),
        fontFamily: 'Roboto',
      ),
      // home: const LoginPage(),
      home: const LoginPage(),
    );
  }
}
