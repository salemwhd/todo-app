// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todo_app/views/new_task_screen.dart';
import 'package:todo_app/views/widget/new_task_button.dart';
import 'package:todo_app/views/widget/tasks_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  void refresh() {
    setState(() {});
  }

  Future<void> _navigateToNewTaskScreen() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NewTaskScreen(),
      ),
    );

    if (result == true) {
      refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'My tasks',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Stack(
        children: [
          TasksList(
            key: UniqueKey(),
            onUpdate: () {
              refresh();
            },
          ),
          Positioned(
            right: 40,
            bottom: 50,
            child: SizedBox(
                width: 140,
                height: 70,
                child: NewTaskButton(
                  onPress: () {
                    return _navigateToNewTaskScreen();
                  },
                )),
          ),
        ],
      ),
    );
  }
}
