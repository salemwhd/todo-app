import 'package:intl/intl.dart';

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
    required this.dateTime,
    this.isCompleted = false,
  });

  String get formatDateTime => DateFormat('dd-MM-yyyy HH:mm').format(dateTime);
}
