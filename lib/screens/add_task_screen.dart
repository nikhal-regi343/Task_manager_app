import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task_model.dart';
import '../providers/task_provider.dart';
import '../utils/date_time_utils.dart';
import '../widgets/task_form_field.dart';
import '../widgets/date_time_picker.dart';
import 'main_screen.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  DateTime? _selectedStartDate;
  TimeOfDay? _selectedStartTime;
  DateTime? _selectedEndDate;
  TimeOfDay? _selectedEndTime;
  String _title = '';
  String _label = '';
  String _priority = 'Low';
  String _desc = '';
  final List<String> _priorityOptions = ['Low', 'Medium', 'High'];

  final _titleController = TextEditingController();
  final _labelController = TextEditingController();
  final _descController = TextEditingController();

  bool _sameStartEndDate = true;

  @override
  void dispose() {
    _titleController.dispose();
    _labelController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _selectStartDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedStartDate) {
      setState(() {
        _selectedStartDate = pickedDate;
        if (_sameStartEndDate) {
          _selectedEndDate = pickedDate;
        }
      });
    }
  }

  Future<void> _selectEndDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedEndDate) {
      setState(() {
        _selectedEndDate = pickedDate;
      });
    }
  }

  Future<void> _selectStartTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != _selectedStartTime) {
      setState(() {
        _selectedStartTime = pickedTime;
        if (_sameStartEndDate) {
          _selectedEndTime = pickedTime;
        }
      });
    }
  }

  Future<void> _selectEndTime() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != _selectedEndTime) {
      setState(() {
        _selectedEndTime = pickedTime;
      });
    }
  }

  void _saveTask() {
    if (_selectedStartTime != null &&
        _selectedStartDate != null &&
        _selectedEndTime != null &&
        _selectedEndDate != null &&
        (!_selectedEndDate!.isBefore(_selectedStartDate!) ||
            (!_selectedEndDate!.isBefore(_selectedStartDate!) &&
                _selectedEndTime!.hour >= _selectedStartTime!.hour &&
                _selectedEndTime!.minute >= _selectedStartTime!.minute))) {
      final DateTime startDateTime = DateTime(
        _selectedStartDate!.year,
        _selectedStartDate!.month,
        _selectedStartDate!.day,
        _selectedStartTime!.hour,
        _selectedStartTime!.minute,
      );

      final DateTime endDateTime = DateTime(
        _selectedEndDate!.year,
        _selectedEndDate!.month,
        _selectedEndDate!.day,
        _selectedEndTime!.hour,
        _selectedEndTime!.minute,
      );

      Color valueColor = Colors.black12;

      final TaskModel newTask = TaskModel(
        startDate: startDateTime,
        endDate: endDateTime,
        startTime: formatTime(startDateTime),
        endTime: formatTime(endDateTime),
        title: _title,
        label: _label,
        priority: _priority,
        status: 'Pending',
        color: valueColor,
        description: _desc,
      );

      Provider.of<TaskProvider>(context, listen: false).addTask(newTask);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    } else {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Date/Time'),
          content: const Text(
              'End date and time must be after or equal to start date and time.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TaskFormFields(
              titleController: _titleController,
              labelController: _labelController,
              descController: _descController,
              title: 'Title',
              label: 'Label',
              description: 'Description',
              onTitleChanged: (value) {
                setState(() {
                  _title = value;
                });
              },
              onLabelChanged: (value) {
                setState(() {
                  _label = value;
                });
              },
              onDescriptionChanged: (value) {
                setState(() {
                  _desc = value;
                });
              },
            ),
            Row(
              children: [
                DateTimePicker(
                  date: _selectedStartDate,
                  time: _selectedStartTime,
                  label: 'Select Start Date',
                  onTap: _selectStartDate,
                ),
                DateTimePicker(
                  date: _selectedStartDate,
                  time: _selectedStartTime,
                  label: 'Select Start Time',
                  onTap: _selectStartTime,
                  isDate: false,
                ),
              ],
            ),
            Row(
              children: [
                DateTimePicker(
                  date: _selectedEndDate,
                  time: _selectedEndTime,
                  label: 'Select End Date',
                  onTap: _selectEndDate,
                ),
                DateTimePicker(
                  date: _selectedEndDate,
                  time: _selectedEndTime,
                  label: 'Select End Time',
                  onTap: _selectEndTime,
                  isDate: false,
                ),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: _sameStartEndDate,
                  onChanged: (bool? value) {
                    setState(() {
                      _sameStartEndDate = value!;
                      if (_sameStartEndDate) {
                        _selectedEndDate = _selectedStartDate;
                        _selectedEndTime = _selectedStartTime;
                      }
                    });
                  },
                ),
                const Text('Same as start date and time'),
              ],
            ),
            DropdownButton<String>(
              value: _priority,
              onChanged: (String? newValue) {
                setState(() {
                  _priority = newValue!;
                });
              },
              items: _priorityOptions
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveTask,
              child: const Text('Save Task'),
            ),
          ],
        ),
      ),
    );
  }
}
