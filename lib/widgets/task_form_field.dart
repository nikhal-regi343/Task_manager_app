import 'package:flutter/material.dart';

class TaskFormFields extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController labelController;
  final TextEditingController descController;
  final String title;
  final String label;
  final String description;
  final Function(String) onTitleChanged;
  final Function(String) onLabelChanged;
  final Function(String) onDescriptionChanged;

  const TaskFormFields({
    super.key,
    required this.titleController,
    required this.labelController,
    required this.descController,
    required this.title,
    required this.label,
    required this.description,
    required this.onTitleChanged,
    required this.onLabelChanged,
    required this.onDescriptionChanged,
  });

  @override
  Widget build(context) {
    return Column(
      children: [
        TextField(
          controller: titleController,
          decoration: InputDecoration(labelText: title),
          onChanged: onTitleChanged,
        ),
        TextField(
          controller: labelController,
          decoration: InputDecoration(labelText: label),
          onChanged: onLabelChanged,
        ),
        TextField(
          controller: descController,
          decoration: InputDecoration(labelText: description),
          onChanged: onDescriptionChanged,
          maxLines: null,
          keyboardType: TextInputType.multiline,
        ),
      ],
    );
  }
}
