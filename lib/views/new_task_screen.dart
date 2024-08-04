// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/services/database_service.dart';
import 'package:todo_app/views/widget/my_text_filed.dart';

class NewTaskScreen extends StatelessWidget {
  NewTaskScreen({
    super.key,
    this.task,
  }) {
    if (task != null) {
      titleController.text = task!.title;
      descriptionController.text = task!.description;
    }
  }
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TaskModel? task;

  void navigatetoHomeScreen(BuildContext context) {
    Navigator.of(context).pop(true);
  }

  dynamic saveTask(BuildContext context) {
    final title = titleController.text;
    final description = descriptionController.text;
    if (title.isEmpty || description.isEmpty) {
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Please fill all fields'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
    if (task == null) {
      TaskModel newTask = TaskModel(
        title: title,
        description: description,
        dateTime: DateTime.now(),
      );
      DatabaseService.instance.createTask(newTask);
      navigatetoHomeScreen(context);
    } else {
      TaskModel updatedTask = TaskModel(
        id: task!.id,
        title: title,
        description: description,
        dateTime: task!.dateTime,
      );
      DatabaseService.instance.updateTask(updatedTask);
      navigatetoHomeScreen(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: task == null ? Text('New task') : Text('Edit'),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: MyTextFiled(
                      label: 'Title',
                      maxLines: 1,
                      controller: titleController,
                      initialValue: task?.title,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 32, 71, 62),
                    ),
                    onPressed: () {
                      saveTask(context);
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: MyTextFiled(
                label: 'Task description...',
                maxLines: 50,
                controller: descriptionController,
                initialValue: task?.description,
              ),
            )
          ],
        ),
      ),
    );
  }
}
