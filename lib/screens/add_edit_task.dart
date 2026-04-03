import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';

class AddEditTask extends StatefulWidget {
  final Task? task;

  const AddEditTask({super.key, this.task});

  @override
  State<AddEditTask> createState() => _AddEditTaskState();
}

class _AddEditTaskState extends State<AddEditTask> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final descController = TextEditingController();

  DateTime? dueDate;
  String status = "To-Do";
  String? blockedBy;

  @override
  void initState() {
    super.initState();

    if (widget.task != null) {
      titleController.text = widget.task!.title;
      descController.text = widget.task!.description;
      dueDate = widget.task!.dueDate;
      status = widget.task!.status;
      blockedBy = widget.task!.blockedBy;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? "Add Task" : "Edit Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // 📝 Title
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Title"),
                validator: (val) =>
                    val!.isEmpty ? "Enter title" : null,
              ),

              // 📄 Description
              TextFormField(
                controller: descController,
                decoration:
                    const InputDecoration(labelText: "Description"),
              ),

              const SizedBox(height: 10),

              // 📅 Date Picker
              ElevatedButton(
                onPressed: () async {
                  final picked = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                    initialDate: DateTime.now(),
                  );

                  if (picked != null) {
                    setState(() => dueDate = picked);
                  }
                },
                child: Text(
                  dueDate == null
                      ? "Select Due Date"
                      : dueDate.toString().split(' ')[0],
                ),
              ),

              const SizedBox(height: 10),

              // 🔽 Status Dropdown
              DropdownButtonFormField<String>(
                value: status,
                items: ["To-Do", "In Progress", "Done"]
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (val) => setState(() => status = val!),
              ),

              const SizedBox(height: 10),

              // 🔗 Blocked By Dropdown
              DropdownButtonFormField<String>(
                value: blockedBy,
                hint: const Text("Blocked By (Optional)"),
                items: provider.tasks
                    .where((t) => widget.task == null || t.id != widget.task!.id)
                    .map((task) => DropdownMenuItem(
                          value: task.id,
                          child: Text(task.title),
                        ))
                    .toList(),
                onChanged: (val) => setState(() => blockedBy = val),
              ),

              const SizedBox(height: 20),

              // 💾 Save Button
              ElevatedButton(
                onPressed: provider.isLoading
                    ? null
                    : () async {
                        if (!_formKey.currentState!.validate()) return;

                        if (dueDate == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Select due date")),
                          );
                          return;
                        }

                        final task = Task(
                          id: widget.task?.id ?? const Uuid().v4(),
                          title: titleController.text,
                          description: descController.text,
                          dueDate: dueDate!,
                          status: status,
                          blockedBy: blockedBy,
                        );

                        if (widget.task == null) {
                          await provider.addTask(task);
                        } else {
                          widget.task!
                            ..title = task.title
                            ..description = task.description
                            ..dueDate = task.dueDate
                            ..status = task.status
                            ..blockedBy = task.blockedBy;

                          await provider.updateTask(widget.task!);
                        }

                        Navigator.pop(context);
                      },
                child: provider.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}