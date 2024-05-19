import 'package:flutter/material.dart';
import 'package:android_mims_development/services/sales_database_helper.dart';
import 'package:android_mims_development/services/item_database_helper.dart';
import 'package:intl/intl.dart';

class DashboardPage extends StatefulWidget {
  final String email;
  const DashboardPage({Key? key, required this.email}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Future<List<String>>? itemNamesFuture;
  Future<double>? totalSalesFuture;
  late ItemDatabaseHelper itemDb = ItemDatabaseHelper(userEmailOrNumber: widget.email);
  late SaleDatabaseHelper saleDb = SaleDatabaseHelper(userEmailOrNumber: widget.email, itemDbHelper: itemDb);

  @override
  void initState() {
    super.initState();
    totalSalesFuture = saleDb.calculateTotalSales();
    itemNamesFuture = itemDb.getAllItemNames();
  }

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
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                children: [
                  FutureBuilder<double>(
                    future: totalSalesFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        print(snapshot.error);
                        return const Center(child: Text('Error'));
                      } else {
                        return Card(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('💵 Sales Today', textAlign: TextAlign.center,style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                                Text(DateFormat('yyyy-MM-dd').format(DateTime.now()), style: TextStyle(fontSize: 16)),
                                Text('P${snapshot.data}0', style: TextStyle(fontSize: 30)),
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  Container(
                    height: 200,
                    child: FutureBuilder<List<Map<String, dynamic>>>(
                      future: saleDb.getTotalSoldItems(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          print(snapshot.error);
                          return const Center(child: Text('Error'));
                        } else if (snapshot.hasData) {
                          return ListView(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '✅ Items Sold:',
                                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  Map<String, dynamic> item = snapshot.data![index];
                                  return Card(
                                    child: ListTile(
                                      title: Text('📦Item: ${item['itemName']} - ✅Sold: ${item['totalQuantity']}'),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        } else {
                          return const Text('No data');
                        } 
                      },
                    ),
                  ),
                  Container(
                    height: 200,
                    child: FutureBuilder<Map<String, double>>(
                      future: saleDb.getTotalSalesByMonth(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          print(snapshot.error);
                          return const Center(child: Text('Error'));
                        } else if (snapshot.hasData) {
                          return ListView(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '🗓️ Total Sales By Month:',
                                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.entries.length,
                                itemBuilder: (context, index) {
                                  MapEntry<String, double> entry = snapshot.data!.entries.elementAt(index);
                                  return Card(
                                    child: ListTile(
                                      title: Text('📅Month: ${entry.key} ~ 💵Total: P ${entry.value}'),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        } else {
                          return const Text('No data');
                        }
                      },
                    ),
                  ),
                  Container(
                    height: 200,
                    child: FutureBuilder<List<String>>(
                      future: itemNamesFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          print(snapshot.error);
                          return const Center(child: Text('Error'));
                        } else if (snapshot.hasData) {
                          return ListView(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '🔢 Item Quantities:',
                                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  String itemName = snapshot.data![index];
                                  return FutureBuilder<int>(
                                    future: itemDb.getTotalItemQuantity(itemName),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        print(snapshot.error);
                                        return const Text('Error');
                                      } else if (snapshot.hasData) {
                                        return Card(
                                          child: ListTile(
                                            title: Text('📦Item: $itemName - 🔢Quantity: ${snapshot.data}'),
                                          ),
                                        );
                                      } else {
                                        return const Text('No data');
                                      }
                                    },
                                  );
                                },
                              ),
                            ],
                          );
                        } else {
                          return const Text('No data');
                        }
                      },
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