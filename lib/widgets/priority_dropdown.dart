import 'package:flutter/material.dart';

class PriorityDropdown extends StatelessWidget {
  final String value;
  final ValueChanged<String?> onChanged;

  const PriorityDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(context) {
    return DropdownButton<String>(
      value: value,
      onChanged: onChanged,
      items: ['Low', 'Medium', 'High']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
