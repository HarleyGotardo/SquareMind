import 'package:flutter/material.dart';
import 'package:android_mims_development/model/item_model.dart';

class InventoryPage extends StatefulWidget {
  final String email;
  const InventoryPage({super.key, required this.email});

  @override
  // ignore: library_private_types_in_public_api
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
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
                Icon(Icons.inventory, size: 32.0),
                SizedBox(width: 8.0),
                Text(
                  'Inventory Management',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            TextField(
              onChanged: (value) {
                setState(() {
                  //function implementation here
                });
              },
              decoration: const InputDecoration(
                labelText: 'Search',
                suffixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: GridView.builder(
                itemCount: 1,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      2, // Change this number to adjust the number of items in a row
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      //function implemenetation here
                    },
                    child: Card(
                      color: const Color.fromARGB(
                          255, 63, 61, 60), // Change the color of the square
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            15.0), // Add a border radius to the square
                      ),
                      child: const Center(
                          // Add the item name to the square
                          ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your onPressed code here!
        }, // The "+" icon
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        child: const Icon(Icons.add),
      ),
    );
  }
}
