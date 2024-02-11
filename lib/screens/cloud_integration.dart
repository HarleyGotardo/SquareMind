import 'package:flutter/material.dart';

class CloudPage extends StatelessWidget {
  const CloudPage({Key? key}) : super(key: key);

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
                    onPressed: () {
                      // TODO: Implement sync data to cloud
                    },
                    icon: const Icon(Icons.cloud_upload),
                    label: const Text('Sync Data'),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 63, 61, 60)),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // TODO: Implement download data from cloud
                    },
                    icon: const Icon(Icons.cloud_download),
                    label: const Text('Download Data'),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 63, 61, 60)),
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