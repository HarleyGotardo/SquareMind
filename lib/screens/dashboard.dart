import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  final String email;
  const DashboardPage({super.key, required this.email});

  @override
  // ignore: library_private_types_in_public_api
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.dashboard, size: 32.0),
                SizedBox(width: 8.0),
                Text(
                  'Dashboard',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: const [
                  Card(
                    child: Center(child: Text('Card 1')),
                  ),
                  Card(
                    child: Center(child: Text('Card 2')),
                  ),
                  Card(
                    child: Center(child: Text('Card 3')),
                  ),
                  Card(
                    child: Center(child: Text('Card 4')),
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
