import 'package:flutter/material.dart';
import '../utils/bottomnavigation.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isVegMode = false; // Veg Mode toggle state
  bool isDarkMode = false; // Dark Mode toggle state

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(), // Toggle dark and light themes
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Section
              Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    child: Text(
                      'U',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'User',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('View activity clicked')),
                          );
                        },
                        child: const Text(
                          'View activity',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Gold Membership Section
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.crop, color: Colors.amber),
                        SizedBox(width: 8),
                        Text(
                          'Renew your Monthly Membership',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Profile Completion
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Your profile'),
                subtitle: const Text('50% completed'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Your profile clicked')),
                  );
                },
              ),

              // Veg Mode Switch
              ListTile(
                leading: const Icon(Icons.eco),
                title: const Text('Veg Mode'),
                trailing: Switch(
                  value: isVegMode,
                  onChanged: (value) {
                    setState(() {
                      isVegMode = value;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(isVegMode ? 'Veg Mode Enabled' : 'Veg Mode Disabled'),
                      ),
                    );
                  },
                ),
              ),

              // Appearance
              ListTile(
                leading: const Icon(Icons.color_lens),
                title: const Text('Appearance'),
                subtitle: Text(isDarkMode ? 'DARK' : 'LIGHT'),
                trailing: Switch(
                  value: isDarkMode,
                  onChanged: (value) {
                    setState(() {
                      isDarkMode = value;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(isDarkMode ? 'Dark Mode Enabled' : 'Light Mode Enabled')),
                    );
                  },
                ),
              ),

              // Rating
              ListTile(
                leading: const Icon(Icons.star),
                title: const Text('Rate food'),
                // subtitle: const Text('4.61'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Your rating clicked')),
                  );
                },
              ),

              // Food Orders Section
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Food Orders',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),

              ListTile(
                leading: const Icon(Icons.receipt_long),
                title: const Text('Your orders'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  // Navigate to Orders screen
                 
                },
              ),
              ListTile(
                leading: const Icon(Icons.favorite),
                title: const Text('Favorite orders'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Favorite orders clicked')),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.recommend),
                title: const Text('Manage recommendations'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Manage recommendations clicked')),
                  );
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigation(cart: [],),
      ),
    );
  }
}