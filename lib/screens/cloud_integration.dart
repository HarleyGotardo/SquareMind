import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:android_mims_development/screens/firebase_login.dart';
import 'package:android_mims_development/services/sync_service.dart';
import 'package:android_mims_development/services/item_database_helper.dart';
import 'package:android_mims_development/services/sales_database_helper.dart';
import 'package:android_mims_development/services/database_helper.dart';

class CloudPage extends StatefulWidget {
  const CloudPage({super.key});

  @override
  _CloudPageState createState() => _CloudPageState();
}

class _CloudPageState extends State<CloudPage> {
  bool _isLoggedIn = false;
  SyncService? _syncService;
  String? userEmail;
  String? userEmail2;

  @override
  void initState() {
    super.initState();
    _initializeServices();
    _getUserEmailOrNumber().then((value) => userEmail2 = value);
  }

  void _initializeServices() async {
    await _checkLoginStatus();
    if (_isLoggedIn) {
      var firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser != null && firebaseUser.email != null) {
        userEmail = firebaseUser.email;
        final itemDbHelper = ItemDatabaseHelper(userEmailOrNumber: userEmail2 ?? 'defaultEmail');
        final saleDbHelper = SaleDatabaseHelper(userEmailOrNumber: userEmail2 ?? 'defaultEmail', itemDbHelper: itemDbHelper);
_syncService = SyncService(
  user: firebaseUser,
  itemDbHelper: itemDbHelper,
  saleDbHelper: saleDbHelper,
);
      }
    }
    setState(() {});
  }

  Future<void> _checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    var firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await prefs.setBool('isLoggedIn', true);
      isLoggedIn = true;
    } else {
      await prefs.setBool('isLoggedIn', false);
      isLoggedIn = false;
    }

    setState(() {
      _isLoggedIn = isLoggedIn;
    });
  }

  Future<String?> _getUserEmailOrNumber() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    if (username != null) {
      return await DatabaseHelper.instance.getUserEmail(username) as String?;
    } else {
      throw Exception('No username found in SharedPreferences');
    }
  }

  Future<void> _logout() async {
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

  Future<void> _syncData() async {
    try {
      if (_syncService != null) {
        await _syncService!.syncToFirebase();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data synced to cloud')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('SyncService is not initialized')));
      }
    } catch (e) {
      print('Error during syncData: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to sync data: $e')));
    }
  }

  Future<void> _downloadData() async {
    try {
      if (_syncService != null) {
        await _syncService!.downloadFromFirebase();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data downloaded from cloud')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('SyncService is not initialized')));
      }
    } catch (e) {
      print('Error during downloadData: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to download data: $e')));
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
              onPressed: _initializeServices,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  if (_isLoggedIn)
                    ElevatedButton.icon(
                      onPressed: _syncData,
                      icon: const Icon(Icons.cloud_upload),
                      label: const Text('Sync Data'),
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 63, 61, 60)),
                      ),
                    ),
                  if (_isLoggedIn)
                    ElevatedButton.icon(
                      onPressed: _downloadData,
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
                              MaterialPageRoute(builder: (context) => FirebaseLoginPage()),
                            ).then((_) => _checkLoginStatus());
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
  }
}
