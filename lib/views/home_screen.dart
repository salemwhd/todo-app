import 'package:flutter/material.dart';
import 'package:todo_app/data/data.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/views/new_task_screen.dart';
import 'package:todo_app/views/widget/task_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<TaskModel> mytasks = tasks;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('My tasks'),
        ),
      ),
      body: Stack(
        children: [
          ListView.builder(
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
                  child: Icon(Icons.delete),
                ),
                child: TaskCard(task: tasks[index]),
              );
            },
          ),
          Positioned(
            right: 40,
            bottom: 50,
            child: SizedBox(
              width: 140,
              height: 70,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 32, 71, 62),
                    elevation: 5,
                    overlayColor: Colors.black),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewTaskScreen(),
                    ),
                  );
                },
                child: const Text(
                  'New Task',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
