import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // This disables the debug banner.
      title: 'Admin App',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: HomeAdminScreen(),
    );
  }
}

class HomeAdminScreen extends StatelessWidget {
  final List<Map<String, dynamic>> newOrders = [
    {'orderId': 'Order #001', 'status': 'Pending'},
    {'orderId': 'Order #002', 'status': 'Pending'},
    {'orderId': 'Order #003', 'status': 'Pending'},
    {'orderId': 'Order #004', 'status': 'Pending'},
  ];

  void _acknowledgeOrder(BuildContext context, int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${newOrders[index]['orderId']} acknowledged!')),
    );
  }

  void _navigateToAddItemPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddItemPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Home',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'New Orders',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1,
                ),
                itemCount: newOrders.length,
                itemBuilder: (context, index) {
                  final order = newOrders[index];
                  return Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            order['orderId'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Status: ${order['status']}',
                            style: const TextStyle(color: Colors.grey),
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: order['status'] == 'Pending'
                                ? () => _acknowledgeOrder(context, index)
                                : null,
                            child: const Text('Acknowledge'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton.icon(
              onPressed: () => _navigateToAddItemPage(context),
              icon: const Icon(Icons.add),
              label: const Text('Add Item'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Add Item Page (Placeholder)
class AddItemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Item'),
      ),
      body: Center(
        child: Text('Add Item Page Content Here'),
      ),
    );
  }
}
