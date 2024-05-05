import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:workouttracker/auth/login.dart';
// import 'package:workouttracker/auth/registration.dart';
// import 'package:workouttracker/auth/forget_password.dart';
// import 'package:workouttracker/auth/test.dart';
// import 'package:workouttracker/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required for Firebase initialization
  await Firebase.initializeApp(); // Initialize Firebase

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WorkOutTracker',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Login(),
      debugShowCheckedModeBanner: false,
    );
  }
}
