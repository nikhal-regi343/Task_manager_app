import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/task_provider.dart';
import '../widgets/task_item.dart';

class DueTaskScreen extends StatelessWidget {
  const DueTaskScreen({super.key});

  @override
  Widget build(context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final tasks = taskProvider.tasks;
    final dueTasks = tasks
        .where((task) =>
            task.status != 'Completed' && DateTime.now().isAfter(task.endDate))
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pending task"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pending Tasks:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            DropdownButton<String>(
              hint: const Text("Sort by:"),
              items: const [
                DropdownMenuItem(value: 'status', child: Text('Status')),
                DropdownMenuItem(value: 'date', child: Text('Date')),
                DropdownMenuItem(value: 'priority', child: Text('Priority')),
              ],
              onChanged: (value) {
                taskProvider.sortTasksBy(value!);
              },
            ),
            Expanded(
              child: dueTasks.isNotEmpty
                  ? ListView.builder(
                      itemCount: dueTasks.length,
                      itemBuilder: (context, index) {
                        final task = dueTasks[index];
                        return Dismissible(
                          key: Key(task.id.toString()),
                          onDismissed: (direction) {
                            taskProvider.deleteTask(task.id ?? -1);
                          },
                          child: TaskItem(task: task),
                        );
                      },
                    )
                  : const Center(
                      child: Text(
                        'No Pending Tasks..🎉',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
