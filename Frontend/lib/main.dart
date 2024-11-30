import 'package:flutter/material.dart';
import 'screens/login.dart';
import 'screens/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/login.png',
              height: 400,
              width: 400,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 30),
           const SizedBox(height: 30),
ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.orange,
    minimumSize: const Size(200, 50),
  ),
  child: const Text(
    'Login',
    style: TextStyle(color: Colors.black),
  ),
),
const SizedBox(height: 10),
const Text(
  '- OR -',
  style: TextStyle(color: Colors.grey),
),
const SizedBox(height: 10),
ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterScreen()),
    );
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.orange,
    minimumSize: const Size(200, 50), 
  ),
  child: const Text(
    'Register',
    style: TextStyle(color: Colors.black),
  ),
),
          ],
        ),
      ),
    );
  }
}
