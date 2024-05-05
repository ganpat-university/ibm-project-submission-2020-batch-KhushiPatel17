import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GoalSelection extends StatelessWidget {
  final CollectionReference _userCollection = FirebaseFirestore.instance.collection('users'); // Reference to user collection
  final User? user = FirebaseAuth.instance.currentUser;

  GoalSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Your Fitness Goal')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Choose Your Fitness Goal',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () => _selectGoal(context, 'Muscle Gain'),
              child: const Text('Muscle Gain'),
            ),
            ElevatedButton(
              onPressed: () => _selectGoal(context, 'Weight Loss'),
              child: const Text('Weight Loss'),
            ),
            ElevatedButton(
              onPressed: () => _selectGoal(context, 'Keep Fit'),
              child: const Text('Keep Fit'),
            ),
          ],
        ),
      ),
    );
  }

  void _selectGoal(BuildContext context, String goal) async {
    if (user != null) {
      await _userCollection.doc(user!.uid).update({
        'goal': goal,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Goal set to $goal')),
      );
    }
  }
}
