import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'providers/task_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: const TaskManagerApp(),
    ),
  );
}

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(context) {
    return Consumer<TaskProvider>(
      builder: (context, taskProvider, child) {
        return MaterialApp(
          themeMode: taskProvider.themeMode,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: const MainScreen(),
        );
      },
    );
  }
}
