import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatTime(DateTime dateTime) {
  return DateFormat('hh:mm a').format(dateTime);
}

DateTime combineDateAndTime(DateTime date, TimeOfDay time) {
  return DateTime(
    date.year,
    date.month,
    date.day,
    time.hour,
    time.minute,
  );
}
