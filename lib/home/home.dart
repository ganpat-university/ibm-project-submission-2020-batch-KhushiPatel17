import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:workouttracker/home/log_workout.dart'; // Page for logging new workouts
import 'package:workouttracker/home/workout_history.dart'; // Page for viewing workout history
import 'package:workouttracker/home/goal_selection.dart'; // Page for selecting fitness goals

class HomePage extends StatelessWidget {
  final User? user; // Reference to the authenticated user

  const HomePage({super.key, this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workout Tracker'),
        backgroundColor: Colors.deepPurple, // Background color for the app bar
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Corrected spelling
            mainAxisAlignment: MainAxisAlignment.start, // Corrected spelling
            children: [
              // Welcome message with user information
              Text(
                'Welcome, ${user?.email ?? "User"}!',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16), // Corrected spelling

              // Workout overview with blue accents
              const Text(
                "Today's Workouts",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple),
              ),
              const SizedBox(height: 16), // Corrected spelling

              // Card-based layout for workouts
              Card(
                color: Colors.purple[50], // Light purple background
                child: const ListTile(
                  leading: Icon(Icons.run_circle, color: Colors.deepPurple), // Icon for running
                  title: Text('Morning Cardio'),
                  subtitle: Text('30 minutes of running'),
                ),
              ),
              const SizedBox(height: 16), // Corrected spelling

              Card(
                color: Colors.purple[50], // Light purple background
                child: const ListTile(
                  leading: Icon(Icons.fitness_center, color: Colors.deepPurple), // Icon for strength training
                  title: Text('Evening Strength'),
                  subtitle: Text('Bench Press, 3 sets of 10 reps'),
                ),
              ),
              const SizedBox(height: 16), // Corrected spelling

              // Quick action buttons with consistent style
              ElevatedButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LogWorkout()), // Navigates to log workout page
                ),
                icon: const Icon(Icons.add, color: Colors.white), // Icon for adding a workout
                label: const Text('Log a New Workout'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple, // Corrected property
                ),
              ),
              const SizedBox(height: 16), // Corrected spelling

              ElevatedButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WorkoutHistory()), // Navigates to workout history
                ),
                icon: const Icon(Icons.history, color: Colors.white), // Icon for history
                label: const Text('View Workout History'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple, // Corrected property
                ),
              ),
              const SizedBox(height: 16), // Corrected spelling

              ElevatedButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GoalSelection()), // Navigates to goal selection
                ),
                icon: const Icon(Icons.flag, color: Colors.white), // Icon for goal setting
                label: const Text('Set Fitness Goals'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple, // Corrected property
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
