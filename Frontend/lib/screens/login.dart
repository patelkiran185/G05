import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'homescreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _rollNumberController = TextEditingController();
  String _message = '';

  Future<void> _verifyRollNumber(BuildContext context) async {
    String rollNumber = _rollNumberController.text.toUpperCase(); 

   

    if (rollNumber.isEmpty) {
    
      setState(() {
        _message = 'Roll number is required';
      });
      return;
    }

    try {
  
      final response = await http.post(
        Uri.parse('http://192.168.68.198:3000/verify'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'rollnumber': rollNumber}),
      );

  

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
      

        if (responseData['status'] == 'success') {
        
         
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else {
        
          setState(() {
            _message = responseData['message'];
          });
        }
      } else {
      
        setState(() {
          _message = 'Server error. Please try again later.';
        });
      }
    } catch (error) {
    
      setState(() {
        _message = 'Error connecting to the server.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Login',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: _rollNumberController,
              decoration: const InputDecoration(
                labelText: 'Enter Your Roll Number',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                onPressed: () {
                 
                  _verifyRollNumber(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  side: const BorderSide(
                    color: Colors.orange,
                    width: 0,
                  ),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              _message,
              style: const TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}