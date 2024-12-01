import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/bottomnavigation.dart';

class CartScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cart;

  const CartScreen({Key? key, required this.cart}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _upiIdController = TextEditingController();

  void _openGooglePay(double amount, String upiId) async {
    final url = 'upi://pay?pa=$upiId&pn=Your Name&mc=0000&tid=0123456789&tr=1234567890&tn=Payment&am=$amount&cu=INR';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      const playStoreUrl = 'https://play.google.com/store/apps/details?id=com.google.android.apps.nbu.paisa.user';
      if (await canLaunch(playStoreUrl)) {
        await launch(playStoreUrl);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch Google Pay or Play Store')),
        );
      }
    }
  }

  void _openPhonePe(double amount, String upiId) async {
    final url = 'upi://pay?pa=$upiId&pn=Your Name&mc=0000&tid=0123456789&tr=1234567890&tn=Payment&am=$amount&cu=INR';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      const playStoreUrl = 'https://play.google.com/store/apps/details?id=com.phonepe.app';
      if (await canLaunch(playStoreUrl)) {
        await launch(playStoreUrl);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch PhonePe or Play Store')),
        );
      }
    }
  }

  void _showUpiDialog(double amount, Function(double, String) onPay) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter UPI ID'),
          content: TextField(
            controller: _upiIdController,
            decoration: const InputDecoration(
              hintText: 'Enter your UPI ID',
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Pay'),
              onPressed: () {
                final upiId = _upiIdController.text;
                if (upiId.isNotEmpty) {
                  onPay(amount, upiId);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a valid UPI ID')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double total = 0;
    for (var item in widget.cart) {
      total += item['item']['price'] * item['quantity'];
    }
    double gst = total * 0.18; // Assuming 18% GST
    double grandTotal = total + gst;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: Colors.orange,
      ),
      body: widget.cart.isEmpty
          ? const Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.cart.length,
                      itemBuilder: (context, index) {
                        final cartItem = widget.cart[index];
                        return ListTile(
                          leading: Image.asset(
                            cartItem['item']['image'],
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(cartItem['item']['name']),
                          subtitle: Text('Quantity: ${cartItem['quantity']}'),
                          trailing: Text('₹${cartItem['item']['price'] * cartItem['quantity']}'),
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text('Total'),
                    trailing: Text('₹$total'),
                  ),
                  ListTile(
                    title: const Text('GST (18%)'),
                    trailing: Text('₹$gst'),
                  ),
                  ListTile(
                    title: const Text('Grand Total'),
                    trailing: Text('₹$grandTotal'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      _showUpiDialog(grandTotal, _openGooglePay);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      'Pay with Google Pay',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      _showUpiDialog(grandTotal, _openPhonePe);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text(
                      'Pay with PhonePe',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
      bottomNavigationBar: BottomNavigation(cart: widget.cart),
    );
  }
}