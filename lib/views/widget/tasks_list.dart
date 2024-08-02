import 'package:flutter/material.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/views/widget/task_card.dart';

class TasksList extends StatefulWidget {
  const TasksList({super.key});

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        var task = tasks[index];
        return Dismissible(
          key: ValueKey(tasks[index]),
          onDismissed: (direction) {
            setState(() {
              tasks.removeAt(index);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: Duration(seconds: 3),
                content: Text('${task.title} Deleted'),
                action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () {
                      setState(() {
                        tasks.insert(index, task);
                      });
                    }),
              ),
            );
          },
          background: Container(
            alignment: Alignment.centerLeft,
            color: Colors.red,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.delete),
                  Spacer(),
                  Icon(Icons.delete),
                ],
              ),
            ),
          ),
          child: TaskCard(task: tasks[index]),
        );
      },
    );
  }
}
