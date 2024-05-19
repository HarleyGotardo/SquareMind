import 'package:flutter/material.dart';
import 'package:android_mims_development/screens/firebase_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CloudPage extends StatefulWidget {
  const CloudPage({super.key});

  @override
  _CloudPageState createState() => _CloudPageState();
}

class _CloudPageState extends State<CloudPage> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _refreshPage() {
    setState(() {});
  }

  _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    // Check if the user is logged in to Firebase
    var firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      // The user is logged in to Firebase
      await prefs.setBool('isLoggedIn', true);
      isLoggedIn = true;
    } else {
      // The user is not logged in to Firebase
      await prefs.setBool('isLoggedIn', false);
      isLoggedIn = false;
    }

    setState(() {
      _isLoggedIn = isLoggedIn;
    });
  }

  _logout() async {
    final result = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirmation'),
        content: Text('Are you sure you want to logout?'),
        actions: <Widget>[
          TextButton(
            child: Text('No'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: Text('Yes'),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        ],
      ),
    );

    if (result) {
      await FirebaseAuth.instance.signOut();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', false);

      setState(() {
        _isLoggedIn = false;
      });
    }
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(Icons.cloud),
                SizedBox(width: 8.0),
                Text(
                  'Cloud Integration',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
                          IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: () {
                    _refreshPage();
                  },
                ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (_isLoggedIn)
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.cloud_upload),
                    label: const Text('Sync Data'),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 63, 61, 60)),
                    ),
                  ),
                if (_isLoggedIn)
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.cloud_download),
                    label: const Text('Download Data'),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 63, 61, 60)),
                    ),
                  ),
                if (!_isLoggedIn)
                  Text(
                    "You're still not logged in to a cloud account. Please log in first.",
                    style: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 201, 125, 120)),
                  ),
                _isLoggedIn
                    ? ElevatedButton.icon(
                        onPressed: _logout,
                        icon: const Icon(Icons.logout),
                        label: const Text('Logout from Firebase'),
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 63, 61, 60)),
                        ),
                      )
                    : ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FirebaseLoginPage()),
                          );
                        },
                        icon: const Icon(Icons.login),
                        label: const Text('Login to Firebase'),
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(255, 63, 61, 60)),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}}