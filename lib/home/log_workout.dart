import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogWorkout extends StatefulWidget {
  const LogWorkout({super.key});

  @override
  _LogWorkoutState createState() => _LogWorkoutState();
}

class _LogWorkoutState extends State<LogWorkout> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _exerciseController = TextEditingController();
  final TextEditingController _setsController = TextEditingController();
  final TextEditingController _repsController = TextEditingController();
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Log a New Workout')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(labelText: 'Workout Category'),
                validator: (value) => value!.isEmpty ? 'Please enter a category' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _exerciseController,
                decoration: const InputDecoration(labelText: 'Exercise'),
                validator: (value) => value!.isEmpty ? 'Please enter an exercise' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _setsController,
                decoration: const InputDecoration(labelText: 'Sets'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Please enter sets' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _repsController,
                decoration: const InputDecoration(labelText: 'Reps per Set'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Please enter reps' : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _logWorkout,
                child: const Text('Log Workout'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _logWorkout() async {
    if (_formKey.currentState!.validate()) {
      final category = _categoryController.text;
      final exercise = _exerciseController.text;
      final sets = int.parse(_setsController.text);
      final reps = int.parse(_repsController.text);

      await FirebaseFirestore.instance.collection('workouts').add({
        'userId': user?.uid,
        'category': category,
        'exercise': exercise,
        'sets': sets,
        'reps': reps,
        'timestamp': Timestamp.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Workout logged successfully!')),
      );
    }
  }
}
