// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:todo_app/views/new_task_screen.dart';
import 'package:todo_app/views/widget/new_task_button.dart';
import 'package:todo_app/views/widget/tasks_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _needsRefresh = true;
  @override
  void initState() {
    super.initState();
  }

  Future<void> _navigateToNewTaskScreen() async {
    final needsRefresh = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NewTaskScreen(),
      ),
    );

    if (needsRefresh == true) {
      setState(() {
        _needsRefresh = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('My tasks'),
        ),
      ),
      body: Stack(
        children: [
          TasksList(
            key: UniqueKey(),
          ),
          Positioned(
            right: 40,
            bottom: 50,
            child: SizedBox(
              width: 140,
              height: 70,
              child: NewTaskButton(onPress: _navigateToNewTaskScreen),
            ),
          ),
        ],
      ),
    );
  }
}
