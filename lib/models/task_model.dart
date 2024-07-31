class TaskModel {
  final String title;
  final String description;
  bool isCompleted;
  final DateTime dateTime;

  TaskModel({
    required this.title,
    required this.description,
    this.isCompleted = false,
    required this.dateTime,
  });
}
