import 'package:flutter/material.dart';
import '../utils/bottomnavigation.dart';

class ReorderScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cart;

  const ReorderScreen({Key? key, required this.cart}) : super(key: key);

  @override
  _ReorderScreenState createState() => _ReorderScreenState();
}

class _ReorderScreenState extends State<ReorderScreen> {
  final List<Map<String, dynamic>> recentOrders = [
    {
      'id': 1,
      'date': '2023-05-01',
      'total': 250,
      'items': ['Idli', 'Sambar Dosa', 'Tea'],
      'status': 'Delivered'
    },
    {
      'id': 2,
      'date': '2024-11-03',
      'total': 180,
      'items': ['Vada Puri', 'Coffee'],
      'status': 'Processing'
    },
    {
      'id': 3,
      'date': '2024-11-05',
      'total': 320,
      'items': ['Fried Rice', 'Manchuria', 'Spring Roll'],
      'status': 'Delivered'
    },
    {
      'id': 4,
      'date': '2024-11-07',
      'total': 150,
      'items': ['Chapati Meals', 'Tea'],
      'status': 'Delivered'
    },
    {
      'id': 5,
      'date': '2024-11-09',
      'total': 200,
      'items': ['Noodles', 'Chilli Paneer'],
      'status': 'Processing'
    },
    {
      'id': 6,
      'date': '2024-11-11',
      'total': 270,
      'items': ['Pasta', 'Paneer Noodles Mix'],
      'status': 'Delivered'
    },
  ];

  String _selectedFilter = 'All';

  void _showReorderConfirmation(BuildContext context, Map<String, dynamic> order) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Reorder'),
          content: Text('Do you want to reorder the items from ${order['date']}?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Reorder'),
              onPressed: () {
                // Implement reorder logic here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Reorder placed successfully!')),
                );
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reorder', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.orange,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Orders',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                DropdownButton<String>(
                  value: _selectedFilter,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedFilter = newValue!;
                    });
                  },
                  items: <String>['All', 'Delivered', 'Processing']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: recentOrders.length,
              itemBuilder: (context, index) {
                final order = recentOrders[index];
                if (_selectedFilter == 'All' || _selectedFilter == order['status']) {
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ExpansionTile(
                      title: Text('Order #${order['id']}'),
                      subtitle: Text('${order['date']} - ${order['status']}'),
                      trailing: Text(
                        '₹${order['total']}',
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Items:', style: TextStyle(fontWeight: FontWeight.bold)),
                              ...order['items'].map((item) => Text('• $item')).toList(),
                              SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () => _showReorderConfirmation(context, order),
                                child: Text('Reorder'),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.black, backgroundColor: Colors.orange,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigation(cart: widget.cart),
    );
  }
}