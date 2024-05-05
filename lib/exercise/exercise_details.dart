import 'package:flutter/material.dart';
import 'exercise_measurement.dart'; // Importing the exercise measurement page

class ExerciseDetails extends StatelessWidget {
  final String exerciseName;

  const ExerciseDetails({super.key, required this.exerciseName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          exerciseName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange.shade700,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.orange.shade700, Colors.orange.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Exercise image (Placeholder for now)
            const Placeholder(
              fallbackHeight: 200,
              fallbackWidth: double.infinity,
            ),
            const SizedBox(height: 16),
            // Description
            const Text(
              "Description",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "This exercise focuses on...",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            // Steps to do the exercise
            const Text(
              "Steps",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "1. Step one...\n2. Step two...\n3. Step three...",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            // Call-to-action button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExerciseMeasurement(
                        exerciseName: exerciseName,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Start Exercise",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            // Optional user feedback section
            const SizedBox(height: 16),
            const Text(
              "User Feedback",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Row(
              children: [
                Icon(Icons.thumb_up, color: Colors.green),
                SizedBox(width: 8),
                Icon(Icons.thumb_down, color: Colors.red),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
