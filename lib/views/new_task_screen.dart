import 'package:flutter/material.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/services/database_service.dart';
import 'package:todo_app/views/widget/my_text_filed.dart';

class NewTaskScreen extends StatefulWidget {
  final TaskModel? task;

  NewTaskScreen({Key? key, this.task}) : super(key: key);

  @override
  _NewTaskScreenState createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final List<String> categories = ['Personal', 'Work', 'Study'];
  String selectedCategory = 'Personal';

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      titleController.text = widget.task!.title;
      descriptionController.text = widget.task!.description;
      selectedCategory = widget.task!.category;
    }
  }

  void navigatetoHomeScreen(BuildContext context) {
    Navigator.of(context).pop(true);
  }

  void saveTask(BuildContext context) {
    final title = titleController.text;
    final description = descriptionController.text;
    if (title.isEmpty & description.isEmpty) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Alert'),
            content: const Text('Write something to save'),
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
      return;
    }

    final TaskModel taskToSave = TaskModel(
      id: widget.task?.id,
      title: title,
      description: description,
      dateTime: widget.task?.dateTime ?? DateTime.now(),
      category: selectedCategory,
    );

    if (widget.task == null) {
      DatabaseService.instance.createTask(taskToSave);
    } else {
      DatabaseService.instance.updateTask(taskToSave);
    }

    navigatetoHomeScreen(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(widget.task == null ? 'New task' : 'Edit'),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: IconButton(
              onPressed: () {
                saveTask(context);
              },
              icon: const Icon(
                Icons.save,
                size: 35,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MyTextFiled(
                      label: 'Title',
                      maxLines: 1,
                      controller: titleController,
                      initialValue: widget.task?.title,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: DropdownButton<String>(
                    value: selectedCategory,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCategory = newValue!;
                      });
                    },
                    items: categories
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyTextFiled(
                label: 'Task description...',
                maxLines: 50,
                controller: descriptionController,
                initialValue: widget.task?.description,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
