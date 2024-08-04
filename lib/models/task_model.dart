import 'package:intl/intl.dart';

class TaskModel {
  final int? id;
  final String title;
  final String description;
  bool isCompleted;
  final DateTime dateTime;
  final String category;
  TaskModel({
    this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    this.isCompleted = false,
    required this.category,
  });

  String get formatDateTime => DateFormat('dd-MM-yyyy HH:mm').format(dateTime);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime.toIso8601String(),
      'isCompleted': isCompleted ? 0 : 1,
      'category': category,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      dateTime: DateTime.parse(map['dateTime']),
      isCompleted: map['isCompleted'] == 0,
      category: map['category'],
    );
  }
}
