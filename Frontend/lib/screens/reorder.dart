import 'package:flutter/material.dart';
import '../utils/bottomnavigation.dart';

class ReorderScreen extends StatelessWidget {
  const ReorderScreen({Key? key, required List<Map<String, dynamic>> cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reorder Screen'),
      ),
      body: const Center(
        child: Text(
          'Welcome to the Reorder Screen!',
          style: TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: const BottomNavigation(cart: [],),
    );
  }
}
