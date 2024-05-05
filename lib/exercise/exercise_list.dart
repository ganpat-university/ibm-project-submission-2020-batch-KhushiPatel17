import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'exercise_details.dart';
import 'package:workouttracker/services/exercise/exercise_list_service.dart';

class ExerciseList extends StatefulWidget {
  final String category;

  const ExerciseList({super.key, required this.category});

  @override
  _ExerciseListState createState() => _ExerciseListState();
}

class _ExerciseListState extends State<ExerciseList> {
  late List<Map<String, String>> exercises;
  late IconData categoryIcon;
  final TextEditingController _searchController = TextEditingController();
  bool isSorted = false;

  @override
  void initState() {
    super.initState();
    exercises = ExerciseService.getExercisesForCategory(widget.category);
    categoryIcon = ExerciseService.getCategoryIcon(widget.category);
  }

  void _sortExercisesByName() {
    setState(() {
      exercises.sort((a, b) => a['name']!.compareTo(b['name']!));
    });
  }

  void _sortExercisesByLevel() {
    // Define the desired order of levels
    const levelOrder = ['Beginner', 'Intermediate', 'Expert'];

    setState(() {
      exercises.sort((a, b) {
        final levelA = a['level']!;
        final levelB = b['level']!;
        // Sort based on the predefined order
        return levelOrder.indexOf(levelA).compareTo(levelOrder.indexOf(levelB));
      });
    });
  }

  List<Map<String, String>> _filterExercises(String searchTerm) {
    return exercises
        .where((exercise) =>
            exercise['name']!.toLowerCase().contains(searchTerm.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredExercises = _filterExercises(_searchController.text);

    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            Icon(
              categoryIcon,
              color: Colors.white,
              size: 16,
            ),
          ],
        ),
        title: Text(
          "${widget.category} Exercises",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onChanged: (_) => setState(() {}), // Trigger refresh
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.filter_alt),
                  onPressed: () {
                    // Show a menu for sorting/filtering
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: const Icon(Icons.sort_by_alpha),
                              title: const Text("Sort by Name"),
                              onTap: () {
                                _sortExercisesByName();
                                Navigator.pop(context);
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.sort),
                              title: const Text("Sort by Level"),
                              onTap: () {
                                _sortExercisesByLevel();
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredExercises.length,
                itemBuilder: (context, index) {
                  final exercise = filteredExercises[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: ListTile(
                      leading: Icon(
                        FontAwesomeIcons.dumbbell,
                        color: Colors.orange.shade700,
                      ),
                      title: Text(
                        exercise['name']!,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange.shade700,
                        ),
                      ),
                      subtitle: Text(
                        'Level: ${exercise['level']}',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExerciseDetails(
                              exerciseName: exercise['name']!,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
