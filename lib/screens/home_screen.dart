import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../widgets/task_card.dart';
import 'add_edit_task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String search = "";
  String status = "All";

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);
    final tasks = provider.filterTasks(search, status);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Manager"),
        centerTitle: true,
      ),

      // ➕ Add Task Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddEditTask()),
          );
        },
        child: const Icon(Icons.add),
      ),

      body: Column(
        children: [
          // 🔍 SEARCH BAR
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search tasks...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (val) {
                setState(() => search = val);
              },
            ),
          ),

          // 🔽 FILTER DROPDOWN
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: DropdownButtonFormField<String>(
              value: status,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              items: ["All", "To-Do", "In Progress", "Done"]
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (val) {
                setState(() => status = val!);
              },
            ),
          ),

          const SizedBox(height: 10),

          // 📋 TASK LIST
          Expanded(
            child: tasks.isEmpty
                ? const Center(
                    child: Text(
                      "No Tasks Found",
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (_, i) {
                      return TaskCard(task: tasks[i]);
                    },
                  ),
          ),

          // ⏳ LOADING INDICATOR (IMPORTANT REQUIREMENT)
          if (provider.isLoading)
            const Padding(
              padding: EdgeInsets.all(10),
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}