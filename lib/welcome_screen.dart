import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  final String userEmail; // The user's email passed from the login screen

  const WelcomeScreen({super.key, required this.userEmail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: Center(
        child: Text(
          'Hello, welcome $userEmail', // Display the welcome message with the email
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
