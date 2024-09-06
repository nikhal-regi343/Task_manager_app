import 'package:flutter/material.dart';
import 'package:task_manager_app/models/task_model.dart';

final tasks = [
  TaskModel(
      startDate: DateTime(2024, 9, 1),
      endDate: DateTime(2024, 9, 1),
      startTime: '09:00 AM',
      endTime: '11:00 AM',
      title: 'Task 1',
      label: 'Work',
      priority: 'High',
      status: 'Pending',
      color: Colors.orange[100]!,
      description: 'A very long descripition telling story about task 1'),
  TaskModel(
      startDate: DateTime(2024, 9, 2),
      endDate: DateTime(2024, 9, 2),
      startTime: '12:00 PM',
      endTime: '11:00 AM',
      title: 'Task 2',
      label: 'Personal',
      priority: 'Medium',
      status: 'Completed',
      color: Colors.green[100]!,
      description: 'A very long descripition telling story about task 2'),
  TaskModel(
      startDate: DateTime(2024, 9, 3),
      endDate: DateTime(2024, 9, 3),
      startTime: '03:00 PM',
      endTime: '11:00 AM',
      title: 'Task 3',
      label: 'Work',
      priority: 'Low',
      status: 'In Progress',
      color: Colors.blue[100]!,
      description: 'A very long descripition telling story about task 3'),
];
