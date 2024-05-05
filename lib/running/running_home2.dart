import 'package:flutter/material.dart';
import 'running_tracker.dart'; // Importing the Running Tracker page
import 'run_data.dart'; // Assuming RunData class is in a separate file

class RunningGoalPage extends StatefulWidget {
  const RunningGoalPage({super.key});

  @override
  _RunningGoalPageState createState() => _RunningGoalPageState();
}

class _RunningGoalPageState extends State<RunningGoalPage> {
  final TextEditingController _goalController = TextEditingController();
  List<RunData> previousRuns =
      _generateDummyData(); // Dummy data for previous runs

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Set Running Goal"),
        backgroundColor: Colors.orange, // Orange theme
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Enter Your Running Goal (in meters):",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _goalController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Running Goal (meters)',
                  suffixIcon:
                      Icon(Icons.flag, color: Colors.orange), // Icon for goal
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _startRunning,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners
                  ),
                ), // Navigate to the tracker
                child: const Text("Start Running"),
              ),
              const SizedBox(height: 16),
              _buildPreviousRuns(), // Display previous runs
            ],
          ),
        ),
      ),
    );
  }

  void _startRunning() {
    final goal = double.tryParse(_goalController.text);
    if (goal != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RunningTracker(
            goal: goal, // Pass the goal to the tracker
          ),
        ),
      );
    }
  }

  Widget _buildPreviousRuns() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Previous Runs",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          const SizedBox(height: 16),
          for (var run in previousRuns) // Display previous runs
            ListTile(
              leading: const Icon(Icons.directions_run, color: Colors.orange),
              title: Text(
                "${run.distance.toStringAsFixed(2)} m",
              ),
              subtitle: Text(
                "Time: ${run.time.toStringAsFixed(2)} mins, Avg Speed: ${run.avgSpeed.toStringAsFixed(2)} km/h",
              ),
            ),
        ],
      ),
    );
  }

  static List<RunData> _generateDummyData() {
    final List<RunData> data = [];
    for (int i = 0; i < 10; i++) {
      data.add(RunData(
        (i + 1) * 2.5 * 1000, // Convert to meters
        (i + 1) * 10,
        ((i + 1) * 2.5 * 1000) / ((i + 1) * 10 / 60), // Average speed
      ));
    }
    return data;
  }
}
