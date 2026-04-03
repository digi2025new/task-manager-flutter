import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/task.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> tasks = [];
  bool isLoading = false;

  late Box<Task> taskBox;

  Future init() async {
    taskBox = await Hive.openBox<Task>('tasks');
    tasks = taskBox.values.toList();
    notifyListeners();
  }

  Future addTask(Task task) async {
    if (isLoading) return;

    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    await taskBox.put(task.id, task);
    tasks = taskBox.values.toList();

    isLoading = false;
    notifyListeners();
  }

  Future updateTask(Task task) async {
    if (isLoading) return;

    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    await task.save();
    tasks = taskBox.values.toList();

    isLoading = false;
    notifyListeners();
  }

  Future deleteTask(Task task) async {
    await task.delete();
    tasks = taskBox.values.toList();
    notifyListeners();
  }

  List<Task> filterTasks(String query, String status) {
    return tasks.where((task) {
      final matchesSearch =
          task.title.toLowerCase().contains(query.toLowerCase());

      final matchesStatus =
          status == "All" ? true : task.status == status;

      return matchesSearch && matchesStatus;
    }).toList();
  }

  bool isBlocked(Task task) {
    if (task.blockedBy == null) return false;

    try {
      final blockedTask =
          tasks.firstWhere((t) => t.id == task.blockedBy);
      return blockedTask.status != "Done";
    } catch (e) {
      return false;
    }
  }

  Task? getTaskById(String id) {
    try {
      return tasks.firstWhere((t) => t.id == id);
    } catch (e) {
      return null;
    }
  }
}