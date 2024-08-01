class TaskModel {
  final int id;
  final String title;
  final String description;
  bool isCompleted;
  final DateTime dateTime;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted=false,
    required this.dateTime,
  });
}
