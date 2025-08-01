import 'package:flutter/material.dart';
import '../screens/task_screen.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final ValueChanged<bool> onChanged;

  const TaskTile({super.key, required this.task, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white24,
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        leading: Icon(task.icon, color: Colors.white),
        title: Text(task.title,
            style: TextStyle(
                color: Colors.white,
                decoration: task.isDone ? TextDecoration.lineThrough : null)),
        trailing: Checkbox(
          value: task.isDone,
          onChanged: (val) => onChanged(val!),
          checkColor: Colors.black,
          activeColor: Colors.greenAccent,
        ),
      ),
    );
  }
}
