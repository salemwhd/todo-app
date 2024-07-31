import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/views/widget/task_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final TaskModel task = TaskModel(
    title: 'my new task',
    description: 'hello, there is my task i am working on it right now',
    dateTime: DateTime.now(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('My tasks'),
        ),
      ),
      body: TaskCard(task: task),
    );
  }
}
