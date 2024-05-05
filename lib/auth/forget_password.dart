import 'package:flutter/material.dart';
import 'package:workouttracker/services/auth/forget_password_service.dart'; // ForgetPasswordService

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final TextEditingController _emailController = TextEditingController();
  final ForgetPasswordService _forgetPasswordService = ForgetPasswordService(); // ForgetPasswordService

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reset Password')), // App bar with a simple title
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Corrected spelling
          crossAxisAlignment: CrossAxisAlignment.center, // Corrected spelling
          children: [
            const Text(
              'Enter your email to receive a password reset link.',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16), // Corrected spelling

            // Email Text Field
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email', // Minimalistic label
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email), // Simple email icon
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16), // Corrected spelling

            // Reset Password Button
            ElevatedButton(
              onPressed: _resetPassword, // Simple button text
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32), // Basic padding
              ),
              child: const Text('Send Reset Link'),
            ),
          ],
        ),
      ),
    );
  }

  // Password reset logic
  void _resetPassword() async {
    final email = _emailController.text;

    try {
      await _forgetPasswordService.sendPasswordResetEmail(email);

      // Success message after sending the reset email
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Password reset link sent to $email.')),
      );

    } catch (e) {
      // Error handling if sending fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to send reset link: $e")),
      );
    }
  }
}
