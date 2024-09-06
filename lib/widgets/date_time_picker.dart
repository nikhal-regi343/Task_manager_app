import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePicker extends StatelessWidget {
  final DateTime? date;
  final TimeOfDay? time;
  final String label;
  final void Function() onTap;
  final bool isDate;

  const DateTimePicker({
    super.key,
    required this.date,
    required this.time,
    required this.label,
    required this.onTap,
    this.isDate = true,
  });

  @override
  Widget build(context) {
    return Expanded(
      child: ListTile(
        title: Text(
          isDate
              ? (date == null ? label : DateFormat('dd MMM').format(date!))
              : (time == null ? label : time!.format(context)),
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
        ),
        trailing: Icon(isDate ? Icons.calendar_today : Icons.access_time),
        onTap: onTap,
      ),
    );
  }
}
