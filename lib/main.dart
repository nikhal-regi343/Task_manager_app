import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'providers/task_provider.dart';
import 'package:provider/provider.dart';

// 4) dissemble should also have the edit slider as well.
// 7) local notification
// 9) when i press add new and go back without saving it should store the data in that.
// 10) redesign the ui of desc.

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
      builder: (context, taskProvider, _) {
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
