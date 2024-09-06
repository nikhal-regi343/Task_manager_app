import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../screens/task_detail_screen.dart';

class TaskItem extends StatefulWidget {
  final TaskModel task;

  const TaskItem({super.key, required this.task});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.task.status == 'Completed';
  }

  void _toggleCheckbox(bool? value) {
    setState(() {
      _isChecked = value ?? false;
      widget.task.status = _isChecked ? 'Completed' : 'Pending';
    });
  }

  @override
  Widget build(context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Time Column
        SizedBox(
          width: 90,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${widget.task.startDate.day.toString().padLeft(2, '0')} ${_monthNames[widget.task.startDate.month - 1]}', // Format date
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    widget.task.startTime,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
              // Vertical Line
              Positioned(
                top: 0,
                right: 10,
                child: Container(
                  width: 2,
                  height: 60,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        // Task Details
        Expanded(
          child: Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(
              color: _getPriorityColor(widget.task.priority),
              // color: widget.task.color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Label: ${widget.task.label}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Priority: ${widget.task.priority}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    // Checkbox below description
                    Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.task.status,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          Checkbox(
                            value: _isChecked,
                            onChanged: _toggleCheckbox,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.info, color: Colors.blue),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TaskDetailScreen(task: widget.task),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'High':
        return Colors.red[100]!;
      case 'Medium':
        return Colors.orange[100]!;
      case 'Low':
        return Colors.yellow[100]!;
      default:
        return Colors.blue[100]!;
    }
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
