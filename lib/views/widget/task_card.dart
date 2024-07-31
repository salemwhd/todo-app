import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task});
  final TaskModel task;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Card(
        elevation: 5.0,
        margin: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      task.description,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Checkbox(
                value: task.isCompleted,
                onChanged: (bool? newValue) {
                  task.isCompleted = newValue!;
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
