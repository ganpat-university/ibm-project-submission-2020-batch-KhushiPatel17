  import 'package:flutter/material.dart';
  import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // For Google icon
  import 'package:workouttracker/services/auth/login_service.dart'; // Import the LoginService
  import 'package:workouttracker/auth/forget_password.dart';
  import 'package:workouttracker/auth/registration.dart';
  import 'package:workouttracker/welcome_screen.dart'; // Import the WelcomeScreen

  class Login extends StatefulWidget {
  const Login({super.key});

    @override
    _LoginState createState() => _LoginState();
  }

  class _LoginState extends State<Login> {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final LoginService _LoginService = LoginService(); // Instance of LoginService

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome to WorkOutTracker',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),

                  // Email Text Field
                  TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),

                  // Password Text Field
                  TextField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 24),

                  // Login Button
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Google Login Button
                  ElevatedButton(
                    onPressed: _loginWithGoogle,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children:
                      [
                        Icon(FontAwesomeIcons.google), // Google icon
                        SizedBox(width: 8),
                        Text('Sign in with Google'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Forgot Password
                  TextButton(
                    onPressed: _forgotPassword,
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Create New Account
                  TextButton(
                    onPressed: _createAccount,
                    child: const Text(
                      'Create New Account',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    // Email/password login logic with LoginService
    void _login() {
      final email = _emailController.text;
      final password = _passwordController.text;

      _LoginService.signInWithEmailAndPassword(email, password,context).then((user) {
        if (user != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WelcomeScreen(userEmail: email)),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Login failed. Please check your credentials and try again.")),
          );
        }
      }).catchError((e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error during login: $e")),
        );
      });
    }

    // Google sign-in logic with LoginService
    void _loginWithGoogle() {
      _LoginService.signInWithGoogle(context).then((user) {
        if (user != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WelcomeScreen(userEmail: user.email ?? '')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Google sign-in failed. Please try again.")),
          );
        }
      }).catchError((e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error during Google sign-in: $e")),
        );
      });
    }

    // Forgot password and create account placeholders
    void _forgotPassword() {
      // Implement forgot password logic if needed
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ForgetPassword()),
      );
    }

    void _createAccount() {
      // Implement account creation logic if needed
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Registration()),
      );
    }
  }
