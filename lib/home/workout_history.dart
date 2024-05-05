import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WorkoutHistory extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  WorkoutHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Workout History')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('workouts')
            .where('userId', isEqualTo: user?.uid) // Fetch workouts for the current user
            .orderBy('timestamp', descending: true)
            .snapshots(), // Real-time updates
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Loading indicator
          }

          final workouts = snapshot.data?.docs ?? []; // List of workout documents

          return ListView.builder(
            itemCount: workouts.length,
            itemBuilder: (context, index) {
              final workout = workouts[index];
              return ListTile(
                title: Text(workout['exercise']), // Exercise name
                subtitle: Text(
                  'Category: ${workout['category']}\nSets: ${workout['sets']}, Reps: ${workout['reps']}',
                ),
                trailing: Text(workout['timestamp'].toDate().toString()), // Date of the workout
              );
            },
          );
        },
      ),
    );
  }
}
