// exercise_measurement.dart
import 'package:flutter/material.dart';
import 'dart:async'; // Timer for tracking exercise
import 'package:percent_indicator/circular_percent_indicator.dart'; // Circular progress indicator

class ExerciseMeasurement extends StatefulWidget {
  final String exerciseName;

  const ExerciseMeasurement({super.key, required this.exerciseName});

  @override
  _ExerciseMeasurementState createState() => _ExerciseMeasurementState();
}

class _ExerciseMeasurementState extends State<ExerciseMeasurement> {
  bool isRunning = false;
  int runTime = 0; // Running time in seconds
  Timer? runTimer; // Timer for tracking run time

  int totalReps = 0; // Track total repetitions
  int totalSets = 0; // Track total sets

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercise: ${widget.exerciseName}"),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircularPercentIndicator(
              radius: 100,
              lineWidth: 12,
              percent: runTime / 3600, // Assuming one-hour max duration
              center: Text(
                "${(runTime / 60).toStringAsFixed(1)} mins",
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange),
              ),
              progressColor: Colors.orange,
            ),
            const SizedBox(height: 20),
            Text(
              "Total Reps: $totalReps",
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              "Total Sets: $totalSets",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isRunning ? _pauseExercise : _startExercise,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(isRunning ? "Pause" : "Start"),
            ),
            const SizedBox(width: 16),
            if (isRunning) // Show the stop button only when running
              ElevatedButton(
                onPressed: _stopExercise,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Stop"),
              ),
          ],
        ),
      ),
    );
  }

  void _startExercise() {
    if (!isRunning) {
      setState(() {
        isRunning = true;
        runTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
          runTime++; // Increment running time
        });
      });
    }
  }

  void _pauseExercise() {
    if (isRunning) {
      setState(() {
        isRunning = false; // Pause running
        runTimer?.cancel(); // Stop the timer
      });
    }
  }

  void _stopExercise() {
    if (isRunning) {
      _pauseExercise(); // Pause running
      // Here you can add additional functionality for stopping the exercise
    }
  }
}
