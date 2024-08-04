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

  final Map<String, IconData> categoryIcons = {
    'Personal': Icons.person,
    'Work': Icons.work,
    'Study': Icons.school,
  };
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
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.all(8),
        color: Colors.white,
        child: ListTile(
          leading: Icon(
            categoryIcons[widget.task.category],
            color: Colors.blueGrey,
          ),
          title: Text(widget.task.title,
              style: TextStyle(
                  decoration: isCompleted ? TextDecoration.lineThrough : null,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.task.description,
                style: TextStyle(
                  decoration: isCompleted ? TextDecoration.lineThrough : null,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Container(
                alignment: Alignment.bottomRight,
                child: Text(
                  widget.task.formatDateTime,
                ),
              ),
            ],
          ),
          trailing: Checkbox(
            value: isCompleted,
            onChanged: checkBoxONChange,
          ),
        ),
      ),
    );
  }
}
