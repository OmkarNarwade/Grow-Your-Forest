import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/task_tile.dart';
import 'forest_screen.dart';
import 'package:intl/intl.dart';

final taskListProvider = StateProvider<List<Task>>((ref) => _generateTasks());
final completedTaskCountProvider = StateProvider<int>((ref) => 0);

class TaskScreen extends ConsumerWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskListProvider);
    final completedCount = ref.watch(completedTaskCountProvider);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/background_image.jpg', fit: BoxFit.cover),
          Container(color: Colors.black.withOpacity(0.2)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Daily Weight Loss Tasks',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                const SizedBox(height: 6),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Today\'s Date: ${DateFormat('d MMM yyyy').format(DateTime.now())}",
                    style: const TextStyle(color: Colors.white70),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return TaskTile(
                        task: task,
                        onChanged: (val) {
                          ref.read(completedTaskCountProvider.notifier).state +=
                              val ? 1 : -1;
                          task.isDone = val;
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: ElevatedButton(
                    onPressed: completedCount >= 3
                        ? () {
                            ref
                                .read(completedTaskCountProvider.notifier)
                                .state = 0;
                            ref.read(taskListProvider.notifier).state =
                                _generateTasks();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const ForestScreen()));
                          }
                        : null,
                    child: const Text('🌱 Plant Tree'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Task {
  final String title;
  final IconData icon;
  bool isDone;

  Task(this.title, this.icon, {this.isDone = false});
}

List<Task> _generateTasks() {
  final allTasks = [
    Task('Walk 10,000 steps', Icons.directions_walk),
    Task('Drink 8 glasses of water', Icons.local_drink),
    Task('30 mins cardio', Icons.fitness_center),
    Task('Avoid sugar today', Icons.no_food),
    Task('Eat healthy salad', Icons.restaurant),
    Task('Sleep 7+ hours', Icons.bedtime),
    Task('Stretch 15 minutes', Icons.accessibility),
    Task('Track calories', Icons.track_changes),
  ];
  allTasks.shuffle(Random());
  return allTasks.take(3).toList();
}
