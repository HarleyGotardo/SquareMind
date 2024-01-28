import 'package:android_mims_development/screens/login_screen.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Registration Page',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        )
        ),
        centerTitle: true,
      ),
      body: Center(
      child: TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage())
              
          );
        }, child: const Text('Register Account'), 

      
      )
      ));
  }
}