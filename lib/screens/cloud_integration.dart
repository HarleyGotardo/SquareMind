// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:android_mims_development/services/item_database_helper.dart';
// import 'package:android_mims_development/services/sales_database_helper.dart';
// import 'package:android_mims_development/services/database_helper.dart';
import 'package:android_mims_development/screens/firebase_login.dart';

class CloudPage extends StatefulWidget {
  const CloudPage({super.key});

  @override
  _CloudPageState createState() => _CloudPageState();
}

class _CloudPageState extends State<CloudPage> {

  @override
  void initState() {
    super.initState();
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
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.cloud_upload),
                    label: const Text('Sync Data'),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 63, 61, 60)),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                    },
                    icon: const Icon(Icons.cloud_download),
                    label: const Text('Download Data'),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 63, 61, 60)),
                    ),
                  ),
                        ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FirebaseLoginPage()),
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
  }
}
