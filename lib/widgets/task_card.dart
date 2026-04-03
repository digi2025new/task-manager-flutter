import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import '../screens/add_edit_task.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);
    final isBlocked = provider.isBlocked(task);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      color: isBlocked ? Colors.grey[300] : Colors.white, // 🔥 Blocked UI
      child: ListTile(
        title: Text(
          task.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration:
                isBlocked ? TextDecoration.lineThrough : null,
          ),
        ),

        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.description),
            Text("Due: ${task.dueDate.toString().split(' ')[0]}"),
            Text("Status: ${task.status}"),
          ],
        ),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ✏️ Edit
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddEditTask(task: task),
                  ),
                );
              },
            ),

            // 🗑 Delete
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                provider.deleteTask(task);
              },
            ),
          ],
        ),
      ),
    );
  }
}