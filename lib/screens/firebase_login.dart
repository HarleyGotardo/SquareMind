import 'package:flutter/material.dart';
import 'package:android_mims_development/screens/firebase_signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:android_mims_development/screens/cloud_integration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseLoginPage extends StatefulWidget {
  @override
  _FirebaseLoginPageState createState() => _FirebaseLoginPageState();
}

class _FirebaseLoginPageState extends State<FirebaseLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/images/firebase.png'),
        ),
        title: const Text(
          'Firebase Login Page',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Text(
                'Login to Firebase first to use the cloud integration feature. This feature requires internet. Please make sure that you have an internet connection before proceeding.',
                style: TextStyle(fontSize: 16.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
ElevatedButton(
  onPressed: () async {
    try {
await FirebaseAuth.instance.signInWithEmailAndPassword(
  email: _emailController.text.trim(),
  password: _passwordController.text,
);
// SharedPreferences prefs = await SharedPreferences.getInstance();
      // Show an AlertDialog when login is successful
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Logged in successfully.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                   // Refresh the CloudPage
                  Navigator.pop(context); // Go back to the previous page
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      if (e is FirebaseAuthException) {
        String message = 'Non-Existent Account.';
        if (e.code == 'user-not-found') {
          message = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          message = 'Wrong password provided for that user.';
        }

        // Show an AlertDialog with the error message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text(message),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  },
  child: Text('Login'),
),
              SizedBox(height: 16.0),
              Text("Don't have an account?"),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Handle create account action
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FirebaseSignInPage()),
                  );
                },
                child: Text('Create account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}