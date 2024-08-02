import 'package:flutter/material.dart';
import 'package:todo_app/views/new_task_screen.dart';

class NewTaskButton extends StatelessWidget {
  const NewTaskButton({super.key});

  void navigateToNewTaskScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewTaskScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 32, 71, 62),
          elevation: 5,
          overlayColor: Colors.black),
      onPressed: () {
        navigateToNewTaskScreen(context);
      },
      child: const Text(
        'New Task',
        style: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}
