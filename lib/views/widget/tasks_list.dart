// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/services/database_service.dart';
import 'package:todo_app/views/widget/task_card.dart';

class TasksList extends StatefulWidget {
  const TasksList({
    super.key,
    required this.onUpdate,
  });
  final VoidCallback onUpdate;

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  late Future<List<TaskModel>> _tasks;

  @override
  void initState() {
    super.initState();
    _tasks = DatabaseService.instance.getAllTasks();
  }

  void _onReorder(int oldIndex, int newIndex) async {
    List<TaskModel> tasks = await _tasks;
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final task = tasks.removeAt(oldIndex);
      tasks.insert(newIndex, task);
    });
    _tasks = Future.value(tasks);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TaskModel>>(
      future: _tasks,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No tasks available'));
        } else {
          final tasks = snapshot.data!;
          return ReorderableListView(
            onReorder: _onReorder,
            children: [
              for (final task in tasks)
                Dismissible(
                  key: ValueKey(task.id),
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.all(16),
                    child: const Row(
                      children: [
                        Icon(Icons.delete, color: Colors.white),
                        Spacer(),
                        Icon(Icons.delete, color: Colors.white),
                      ],
                    ),
                  ),
                  onDismissed: (direction) {
                    DatabaseService.instance.deleteTask(task.id!);
                    setState(() {
                      tasks.remove(task);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Task deleted'),
                        duration: const Duration(seconds: 3),
                        action: SnackBarAction(
                          label: 'UNDO',
                          onPressed: () {
                            DatabaseService.instance.createTask(task);
                            setState(() {
                              tasks.insert(tasks.indexOf(task), task);
                            });
                          },
                        ),
                      ),
                    );
                  },
                  child: TaskCard(
                    task: task,
                    onUpdate: widget.onUpdate,
                  ),
                ),
            ],
          );
        }
      },
    );
  }
}
