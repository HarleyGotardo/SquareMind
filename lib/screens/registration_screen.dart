import 'package:flutter/material.dart';
import 'login_screen.dart'; // Assuming this file exists in the specified location
import 'package:android_mims_development/services/database_helper.dart';
import 'package:android_mims_development/model/user_model.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert'; // for the utf8.encode method

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
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
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 19, 16, 57),
        title: const Text(
          'QUICK STOCK by Square Minds',
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 255, 255, 255)),
          textAlign: TextAlign.left,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/square_mind.png"),
              fit: BoxFit.cover,
            ),
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
                  'Mobile Inventory and Sales Management System',
                  style: TextStyle(
                    fontSize: 34.0,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0),
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
                    fillColor: const Color.fromARGB(255, 177, 172, 166),
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
                TextField(
                  controller: _usernameController,
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
                    fillColor: const Color.fromARGB(255, 177, 172, 166),
                  ),
                ),
                const SizedBox(
                    height: 20), // Add some space between text fields
                TextField(
                  controller: _passwordController,
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
                    fillColor: const Color.fromARGB(255, 177, 172, 166),
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
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Email or number already exists')),
                      );
                      return;
                    }

                    String hashedPassword = hashPassword(password);
                    final user = User(
                      emailOrNumber: emailOrNumber,
                      username: username,
                      password: hashedPassword,
                    );

                    dbHelper.insert(user);
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
                        const Color.fromRGBO(177, 172, 166, 255)),
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
                      style: TextStyle(color: Colors.white)),
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
