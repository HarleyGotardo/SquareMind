import 'package:flutter/material.dart';
// import 'package:android_mims_development/services/item_database_helper.dart';
//import 'package:share/share.dart';

class CloudPage extends StatefulWidget {
  const CloudPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CloudPageState createState() => _CloudPageState();
}

class _CloudPageState extends State<CloudPage> {
  //final dbHelper = ItemDatabaseHelper.instance;

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
              child: Row(
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
                      // TODO: Implement download data from cloud
                    },
                    icon: const Icon(Icons.cloud_download),
                    label: const Text('Download Data'),
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
