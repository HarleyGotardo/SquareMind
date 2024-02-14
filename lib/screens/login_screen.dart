import 'package:android_mims_development/screens/main_page.dart';
import 'package:android_mims_development/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:android_mims_development/services/database_helper.dart';
// ignore: depend_on_referenced_packages
import 'package:crypto/crypto.dart';
import 'dart:convert'; // for the utf8.encode method

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final dbHelper = DatabaseHelper.instance;

  String hashPassword(String password) {
    var bytes = utf8.encode(password); // data being hashed
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'QUICK STOCK by Square Minds',
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 255, 255)),
          textAlign: TextAlign.left,
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/square_mind.png"),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 100.0,
              ),
              const Text(
                'Mobile Inventory and Sales Management System',
                style: TextStyle(
                  fontSize: 34.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 96.0),
              TextField(
                controller: _usernameController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Enter your username',
                  labelText: 'Username',
                  hintStyle:
                      const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  labelStyle:
                      const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 0, 0, 0),
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 0, 0, 0),
                      width: 2.0,
                    ),
                  ),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 177, 172, 166),
                ),
              ),
              const SizedBox(height: 8.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  labelText: 'Password',
                  hintStyle:
                      const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  labelStyle:
                      const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 0, 0, 0),
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 0, 0, 0),
                      width: 2.0,
                    ),
                  ),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 177, 172, 166),
                ),
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                  onPressed: () async {
                    // Add login functionality here
                    String username = _usernameController.text;
                    String password = _passwordController.text;
                    String hashedPassword = hashPassword(password);
                    bool loginSuccessful =
                        await dbHelper.checkLogin(username, hashedPassword);
                    if (loginSuccessful) {
                      // Navigate to the next screen
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainPage()),
                      );
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Login successful')),
                      );
                    } else {
                      // Show an error message
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Invalid username or password')),
                      );
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color.fromRGBO(177, 172, 166, 255)),
                  ),
                  child: const Text(
                    'LOGIN',
                    style: TextStyle(color: Colors.white),
                  )),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: () async {
                  // Add forgot password functionality here
                  await dbHelper.clearDatabase();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromRGBO(177, 172, 166, 255)),
                ),
                child: const Text('Forgot Password?',
                    style: TextStyle(color: Colors.white)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const RegistrationPage()));
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromRGBO(177, 172, 166, 255)),
                ),
                child: const Text('Register',
                    style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 200.0),
            ],
          ),
        ),
      ),
    );
  }
}
