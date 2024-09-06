import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../widgets/curve.dart';
import 'edit_screen.dart';

class TaskDetailScreen extends StatefulWidget {
  final TaskModel task;

  const TaskDetailScreen({super.key, required this.task});

  @override
  State<TaskDetailScreen> createState() => _TaskDetailScreenState();
}

class _TaskDetailScreenState extends State<TaskDetailScreen> {
  late TaskModel _task;

  @override
  void initState() {
    super.initState();
    _task = widget.task;
  }

  Future<void> _navigateToEditScreen() async {
    final updatedTask = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTaskScreen(task: _task),
      ),
    );

    if (updatedTask != null && updatedTask is TaskModel) {
      setState(() {
        _task = updatedTask;
      });
    }
  }

  @override
  Widget build(context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(120),
        child: ClipPath(
          clipper: CurvedAppBar(),
          child: AppBar(
            title: Text(
              _task.title,
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            backgroundColor: Colors.grey[400],
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: _navigateToEditScreen,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ],
            elevation: 10,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date Range
            Text(
              '${_task.startDate.day.toString().padLeft(2, '0')} ${_monthNames[_task.startDate.month - 1]} ${_task.startDate.year} - ${_task.endDate.day.toString().padLeft(2, '0')} ${_monthNames[_task.endDate.month - 1]} ${_task.endDate.year}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: isDarkMode ? Colors.white70 : Colors.blueGrey,
              ),
            ),
            Text(
              '${_task.startTime} to ${_task.endTime}',
              style: TextStyle(
                fontSize: 14,
                color: isDarkMode ? Colors.white54 : Colors.grey,
              ),
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoLabel('Label:', _task.label, isDarkMode),
                _buildInfoLabel('Priority:', _task.priority, isDarkMode),
              ],
            ),
            const SizedBox(height: 20),

            Text(
              'Description',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white70 : Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _task.description,
              style: TextStyle(
                fontSize: 16,
                color: isDarkMode ? Colors.white54 : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoLabel(String label, String value, bool isDarkMode) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: isDarkMode ? Colors.white70 : Colors.black87,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            color: isDarkMode ? Colors.white54 : Colors.black54,
          ),
        ),
      ],
    );
  }

  final List<String> _monthNames = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
}
