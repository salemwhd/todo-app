import 'package:flutter/material.dart';

class NewTaskButton extends StatelessWidget {
  const NewTaskButton({super.key, required this.onPress});
  final Future<void> Function() onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              const Color.fromARGB(255, 32, 71, 62).withOpacity(0.7),
          elevation: 5,
          overlayColor: Colors.black,
        ),
        onPressed: () {
          onPress();
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
