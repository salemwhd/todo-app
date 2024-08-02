import 'package:flutter/material.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/views/widget/new_task_button.dart';
import 'package:todo_app/views/widget/tasks_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TaskModel> mytasks = tasks;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('My tasks'),
        ),
      ),
      body: const Stack(
        children: [
          TasksList(),
          Positioned(
            right: 40,
            bottom: 50,
            child: SizedBox(
              width: 140,
              height: 70,
              child: NewTaskButton(),
            ),
          ),
        ],
      ),
    );
  }
}
