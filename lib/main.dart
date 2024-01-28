import 'package:flutter/material.dart';
import 'package:android_mims_development/screens/login_screen.dart';
import 'package:android_mims_development/screens/registration_screen.dart';

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
        primaryColor: Colors.blue,
        hintColor: Colors.blueAccent,
        fontFamily: 'Roboto',
      ),
      // home: const LoginPage(),
      home: const RegistrationPage(),
    );
  }
}