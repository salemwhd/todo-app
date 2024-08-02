import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/views/widget/my_text_filed.dart';

class NewTaskScreen extends StatelessWidget {
  NewTaskScreen({
    super.key,
    this.task,
  });
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TaskModel? task;

  void saveTask() {}
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
                    onPressed: saveTask,
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
