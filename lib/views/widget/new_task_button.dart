import 'package:flutter/material.dart';

class NewTaskButton extends StatelessWidget {
  const NewTaskButton({super.key, required this.onPress});
  final Future<void> Function() onPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 32, 71, 62),
          elevation: 5,
          overlayColor: Colors.black),
      onPressed: () {
        onPress();
      },
      child: const Text(
        'New Task',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
