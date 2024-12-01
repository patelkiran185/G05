import 'package:flutter/material.dart';
import '../screens/homescreen.dart';
import '../screens/cart.dart' as cart_screen;
import '../screens/reorder.dart';
import '../screens/settings.dart' as settings_screen;

class BottomNavigation extends StatefulWidget {
  final List<Map<String, dynamic>> cart;

  const BottomNavigation({Key? key, required this.cart}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = <Widget>[
      HomeScreen(cart: widget.cart),
      cart_screen.CartScreen(cart: widget.cart),
      ReorderScreen(cart: widget.cart),
      settings_screen.SettingsScreen(), // Use SettingsScreen here
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => _screens[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.reorder),
          label: 'Reorder',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: const TextStyle(color: Colors.green),
      unselectedLabelStyle: const TextStyle(color: Colors.grey),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      onTap: _onItemTapped,
    );
  }
}