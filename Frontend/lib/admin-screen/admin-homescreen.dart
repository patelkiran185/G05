import 'package:flutter/material.dart';

class HomeAdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Home Screen'),
      ),
      body: Center(
        child: Text('Welcome to the Admin Home Screen!'),
      ),
    );
  }
}