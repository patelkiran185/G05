import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../utils/bottomnavigation.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Map<String, List<Map<String, String>>> foodCategories = {
    'Breakfast': [
      {'image': 'assets/images/Idli.jpeg', 'name': 'Idli'},
      {'image': 'assets/images/Idli Sambhar.jpeg', 'name': 'Idli Sambhar'},
      {'image': 'assets/images/Sambar Dosa.jpeg', 'name': 'Sambar Dosa'},
      {'image': 'assets/images/Vada Puri.jpeg', 'name': 'Vada Puri'},
      {'image': 'assets/images/Tea.jpeg', 'name': 'Tea'},
      {'image': 'assets/images/Coffee.jpeg', 'name': 'Coffee'},
    ],
    'Snacks': [
      {'image': 'assets/images/Samosa.jpeg', 'name': 'Samosa'},
      {'image': 'assets/images/Puff.jpeg', 'name': 'Puff'},
      {'image': 'assets/images/Spring Roll.jpeg', 'name': 'Spring Roll'},
      {'image': 'assets/images/Manchuria.jpeg', 'name': 'Manchuria'},
      {'image': 'assets/images/Gobi 65.jpeg', 'name': 'Gobi 65'},
    ],
    'Meals': [
      {'image': 'assets/images/Chapati Meals.jpeg', 'name': 'Chapati Meals'},
      {'image': 'assets/images/Fried Rice.jpeg', 'name': 'Fried Rice'},
      {'image': 'assets/images/Veg Biriyani.jpeg', 'name': 'Veg Biriyani'},
      {'image': 'assets/images/Paneer Fride Rice.jpeg', 'name': 'Paneer Fried Rice'},
      {'image': 'assets/images/Zeera Rice.jpeg', 'name': 'Jeera Rice'},
    ],
    'Other Dishes': [
      {'image': 'assets/images/Noodles.jpeg', 'name': 'Noodles'},
      {'image': 'assets/images/Chilli Paneer.jpeg', 'name': 'Chilli Paneer'},
      {'image': 'assets/images/Paneer Noodles Mix.jpeg', 'name': 'Paneer Noodles Mix'},
      {'image': 'assets/images/Shezwan Noodles Mix.jpeg', 'name': 'Shezwan Noodles Mix'},
      {'image': 'assets/images/Pasta.jpeg', 'name': 'Pasta'},
    ],
  };

  void _showProductDialog(BuildContext context, Map<String, String> item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int quantity = 1;
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(item['name']!),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    item['image']!,
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (quantity > 1) {
                            setState(() {
                              quantity--;
                            });
                          }
                        },
                      ),
                      Text('$quantity'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: const Text('Add to Cart'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Breakfast':
        return Icons.breakfast_dining;
      case 'Snacks':
        return Icons.fastfood;
      case 'Meals':
        return Icons.lunch_dining;
      case 'Other Dishes':
        return Icons.dinner_dining;
      default:
        return Icons.category;
    }
  }

  Future<bool> _onWillPop() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit App'),
            content: const Text('Do you want to exit the app?'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

void _logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('isLoggedIn');

  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => const MyHomePage()),
    (Route<dynamic> route) => false,
  );
}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.orange,
          centerTitle: true,
          title: const Text(
            'Welcome!',
            style: TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.black),
              onPressed: _logout,
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Order Food',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1,
                  ),
                  itemCount: foodCategories.keys.length,
                  itemBuilder: (context, index) {
                    String category = foodCategories.keys.elementAt(index);
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CategoryDetailScreen(
                              category: category,
                              items: foodCategories[category]!,
                              onItemTap: _showProductDialog,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _getCategoryIcon(category),
                              size: 50,
                              color: Colors.orange,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              category,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: const BottomNavigation(),
      ),
    );
  }
}

class CategoryDetailScreen extends StatelessWidget {
  final String category;
  final List<Map<String, String>> items;
  final Function(BuildContext, Map<String, String>) onItemTap;

  const CategoryDetailScreen({
    Key? key,
    required this.category,
    required this.items,
    required this.onItemTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          category,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return GestureDetector(
            onTap: () => onItemTap(context, item),
            child: Column(
              children: [
                Expanded(
                  child: Image.asset(
                    item['image']!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item['name']!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}