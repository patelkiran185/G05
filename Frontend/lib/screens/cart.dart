import 'package:DigiCanteen/screens/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';

import '../utils/bottomnavigation.dart';

List<Map<String, dynamic>> billDetails = [];

class CartScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cart;

  const CartScreen({Key? key, required this.cart}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final List<Map<String, dynamic>> items = [
    {'image': 'assets/images/Idli.jpeg', 'name': 'Idli', 'price': 25},
    {
      'image': 'assets/images/Idli Sambhar.jpeg',
      'name': 'Idli Sambhar',
      'price': 30
    },
    {
      'image': 'assets/images/Sambar Dosa.jpeg',
      'name': 'Sambar Dosa',
      'price': 50
    },
    {'image': 'assets/images/Vada Puri.jpeg', 'name': 'Vada Puri', 'price': 25},
    {'image': 'assets/images/Tea.jpeg', 'name': 'Tea', 'price': 8},
    {'image': 'assets/images/Coffee.jpeg', 'name': 'Coffee', 'price': 10},
    {'image': 'assets/images/Samosa.jpeg', 'name': 'Samosa', 'price': 10},
    {'image': 'assets/images/Puff.jpeg', 'name': 'Puff', 'price': 15},
    {
      'image': 'assets/images/Spring Roll.jpeg',
      'name': 'Spring Roll',
      'price': 45
    },
    {'image': 'assets/images/Manchuria.jpeg', 'name': 'Manchuria', 'price': 50},
    {'image': 'assets/images/Gobi 65.jpeg', 'name': 'Gobi 65', 'price': 70},
    {
      'image': 'assets/images/Chapati Meals.jpeg',
      'name': 'Chapati Meals',
      'price': 30
    },
    {
      'image': 'assets/images/Fried Rice.jpeg',
      'name': 'Fried Rice',
      'price': 35
    },
    {
      'image': 'assets/images/Veg Biriyani.jpeg',
      'name': 'Veg Biriyani',
      'price': 50
    },
    {
      'image': 'assets/images/Paneer Fride Rice.jpeg',
      'name': 'Paneer Fried Rice',
      'price': 60
    },
    {
      'image': 'assets/images/Zeera Rice.jpeg',
      'name': 'Jeera Rice',
      'price': 40
    },
    {'image': 'assets/images/Noodles.jpeg', 'name': 'Noodles', 'price': 55},
    {
      'image': 'assets/images/Chilli Paneer.jpeg',
      'name': 'Chilli Paneer',
      'price': 50
    },
    {
      'image': 'assets/images/Paneer Noodles Mix.jpeg',
      'name': 'Paneer Noodles Mix',
      'price': 60
    },
    {
      'image': 'assets/images/Shezwan Noodles Mix.jpeg',
      'name': 'Shezwan Noodles Mix',
      'price': 50
    },
    {'image': 'assets/images/Pasta.jpeg', 'name': 'Pasta', 'price': 70},
  ];

  List<Map<String, dynamic>> getRandomItems(int count) {
    final random = Random();
    final randomItems = <Map<String, dynamic>>[];
    final selectedIndices = <int>{};

    while (randomItems.length < count) {
      final index = random.nextInt(items.length);
      if (!selectedIndices.contains(index)) {
        selectedIndices.add(index);
        randomItems.add({
          'image': items[index]['image'],
          'name': items[index]['name'],
          'price': items[index]['price'],
          'quantity': random.nextInt(5) + 1, // Random quantity between 1 and 5
        });
      }
    }

    return randomItems;
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _showPaymentDialog(BuildContext context, double totalAmount, double gst, double grandTotal) async {
  String selectedTimeSlot = '10:00 - 10:30';

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Payment Successful'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total: ₹${totalAmount.toStringAsFixed(2)}'),
            Text('GST (18%): ₹${gst.toStringAsFixed(2)}'),
            Text('Grand Total: ₹${grandTotal.toStringAsFixed(2)}'),
            SizedBox(height: 16),
            Text('You can now choose time slots to take the food.'),
            SizedBox(height: 16),
            StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return DropdownButton<String>(
                  value: selectedTimeSlot,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedTimeSlot = newValue!;
                    });
                  },
                  items: <String>[
                    '10:00 - 10:30',
                    '11:00 - 11:30',
                    '12:00 - 12:30',
                    '13:00 - 13:30',
                    '14:00 - 14:30'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              billDetails = [
                {'label': 'Total', 'value': totalAmount.toStringAsFixed(2)},
                {'label': 'GST (18%)', 'value': gst.toStringAsFixed(2)},
                {'label': 'Grand Total', 'value': grandTotal.toStringAsFixed(2)},
                {'label': 'Time Slot', 'value': selectedTimeSlot},
              ];

              // Clear cart and navigate to HomeScreen
              Navigator.of(context).pop(); // Close the dialog
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => HomeScreen(cart: [],), // Pass an empty cart
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Order placed successfully!'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}


  Future<void> _handlePayment(
      String url, double totalAmount, double gst, double grandTotal) async {
    await _launchURL(url);
    _showPaymentDialog(context, totalAmount, gst, grandTotal);
  }

  @override
  Widget build(BuildContext context) {
    final randomItems = getRandomItems(3);

    // Calculate totals
    double totalAmount = randomItems.fold(
        0, (sum, item) => sum + item['price'] * item['quantity']);
    double gst = totalAmount * 0.18; // 18% GST
    double grandTotal = totalAmount + gst;

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(bottom: 16.0), // Add padding to the bottom
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: randomItems.length,
                itemBuilder: (context, index) {
                  final item = randomItems[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      children: [
                        // Item image
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              image: AssetImage(item[
                                  'image']), // Replace with your asset path
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        // Item details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['name'],
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 4),
                              Text('₹${item['price']} x ${item['quantity']}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Divider(),
            // Total, GST, and Grand Total
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total', style: TextStyle(fontSize: 16)),
                      Text('₹${totalAmount.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('GST (18%)', style: TextStyle(fontSize: 16)),
                      Text('₹${gst.toStringAsFixed(2)}',
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Grand Total',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Text('₹${grandTotal.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            // Payment buttons
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _handlePayment(
                          'https://play.google.com/store/apps/details?id=com.google.android.apps.nbu.paisa.user',
                          totalAmount,
                          gst,
                          grandTotal);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      minimumSize: Size(double.infinity, 48),
                    ),
                    child: Text('Pay with Google Pay'),
                  ),
                  SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      _handlePayment(
                          'https://play.google.com/store/apps/details?id=com.phonepe.app',
                          totalAmount,
                          gst,
                          grandTotal);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      minimumSize: Size(double.infinity, 48),
                    ),
                    child: Text('Pay with PhonePe'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(cart: []),
    );
  }
}
