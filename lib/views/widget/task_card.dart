import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/services/database_service.dart';
import 'package:todo_app/views/new_task_screen.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.task,
    required this.onUpdate,
  });
  final TaskModel task;
 final VoidCallback onUpdate;

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

  void checkBoxONChange(bool? newValue) {
    setState(() {
      widget.task.isCompleted = newValue ?? false;
      isCompleted = widget.task.isCompleted;
    });

    DatabaseService.instance.updateTask(widget.task);
    widget.onUpdate();
  }

  Future<void> _navigateToNewTaskScreen() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NewTaskScreen(
          task: widget.task,
        ),
      ),
    );

    if (result == true) {
      setState(() {});
      widget.onUpdate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _navigateToNewTaskScreen,
      child: SizedBox(
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
                              decoration: isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Checkbox(
                      value: isCompleted,
                      onChanged: checkBoxONChange,
                    )
                  ],
                ),
                Text(widget.task.formatDateTime),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
