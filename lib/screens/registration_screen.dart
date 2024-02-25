import 'package:flutter/material.dart';
import 'login_screen.dart'; // Assuming this file exists in the specified location
import 'package:android_mims_development/services/database_helper.dart';
import 'package:android_mims_development/model/user_model.dart';
// ignore: depend_on_referenced_packages
import 'package:crypto/crypto.dart';
import 'dart:convert'; // for the utf8.encode method

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String hashPassword(String password) {
    var bytes = utf8.encode(password); // data being hashed
    var digest = sha256.convert(bytes);
    return digest.toString();
  }

    final dbHelper = DatabaseHelper.instance;
    final _formKey = GlobalKey<FormState>();

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
            ),
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 80.0),
                  const Text(
                    'Quick Stock',
                    style: TextStyle(
                      fontSize: 34.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                    textAlign: TextAlign.center,
                  ),
                                const Text(
                  'Create an account to get started.',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(255, 63, 61, 60),
                  ),
                  textAlign: TextAlign.center,
                ),

                  const SizedBox(height: 96.0),
                  TextFormField(
                    controller: _numberController,
                    decoration: InputDecoration(
                      labelText: 'Email or Number',
                      hintText: 'Enter your email or mobile phone number',
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
                      fillColor: const Color.fromARGB(255, 255, 255, 255),
                    ),
                    validator: (value) {
                      Pattern pattern =
                          r'^([a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6})|(\+?[0-9]{10,14}$)';
                      RegExp regex = RegExp(pattern as String);
                      if (!regex.hasMatch(value!)) {
                        return 'Enter a valid email or phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                      height: 20), // Add some space between text fields
                  TextFormField(
                    controller: _usernameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                      // You can add more validation logic here if needed
                    },
                    decoration: InputDecoration(
                      labelText: 'Username',
                      hintText: 'Enter your username',
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
                      fillColor: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  const SizedBox(
                      height: 20), // Add some space between text fields
                  TextFormField(
                    controller: _passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                      // You can add more validation logic here if needed
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter your password',
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
                      fillColor: const Color.fromARGB(255, 255, 255, 255),
                    ),
                    obscureText: true, // Passwords should be obscured
                  ),
                  const SizedBox(
                      height: 20), // Add some space between text fields
                  ElevatedButton(
                    onPressed: () async {
                      String emailOrNumber = _numberController.text;
                      String username = _usernameController.text;
                      String password = _passwordController.text;

                      if (!_formKey.currentState!.validate()) {
                        return;
                      }

                      bool emailOrNumberExists =
                          await dbHelper.emailOrNumberExists(emailOrNumber);
                      if (emailOrNumberExists) {
                        // Show an error message
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Email or number already exists!')),
                        );
                        return;
                      } else {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Succesfully created account. Please login to continue!')),
                        );
                      }

                      String hashedPassword = hashPassword(password);
                      final user = User(
                        emailOrNumber: emailOrNumber,
                        username: username,
                        password: hashedPassword,
                      );

                      dbHelper.insert(user);
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                      setState(() {
                        _numberController.clear();
                        _usernameController.clear();
                        _passwordController.clear();
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.blue), // Change the button color to blue
                    ),
                    child: const Text(
                      'Register Account',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                      height: 20), // Add some space between text fields
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    },
                    child: const Text('Already have an account? Login',
                        style: TextStyle(color: Colors.black)),
                  ),
                  const SizedBox(
                    height: 200,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
