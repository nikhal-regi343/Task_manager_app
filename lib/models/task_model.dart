import 'package:flutter/material.dart';

class TaskModel {
  int? id;
  final String title;
  final String description;
  final DateTime startDate;
  final String startTime;
  final DateTime endDate;
  final String endTime;
  final String label;
  final String priority;
  String status;
  final Color color;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.startTime,
    required this.endDate,
    required this.endTime,
    required this.label,
    required this.priority,
    this.status = 'Pending',
    required this.color,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'startDate': startDate.toIso8601String(),
      'startTime': startTime,
      'endDate': endDate.toIso8601String(),
      'endTime': endTime,
      'label': label,
      'priority': priority,
      'status': status,
      'color': color.value,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      startDate: DateTime.parse(map['startDate']),
      startTime: map['startTime'],
      endDate: DateTime.parse(map['endDate']),
      endTime: map['endTime'],
      label: map['label'],
      priority: map['priority'],
      status: map['status'],
      color: Color(map['color']),
    );
  }
}
