import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({super.key, required this.task});
  final TaskModel task;

  @override
  _TaskCardState createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  late bool isCompleted;

  @override
  void initState() {
    super.initState();
    isCompleted = widget.task.isCompleted ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: Card(
        color: Colors.white,
        elevation: 5.0,
        margin: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.task.title,
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              decoration: isCompleted
                                  ? TextDecoration.lineThrough
                                  : null),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          widget.task.description,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            decoration:
                                isCompleted ? TextDecoration.lineThrough : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Checkbox(
                    value: isCompleted,
                    onChanged: (bool? newValue) {
                      setState(
                        () {
                          widget.task.isCompleted = newValue ?? false;
                          isCompleted = widget.task.isCompleted;
                        },
                      );
                    },
                  )
                ],
              ),
              Text(widget.task.formatDateTime),
            ],
          ),
        ),
      ),
    );
  }
}
