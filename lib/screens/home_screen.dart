import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../widgets/task_item.dart';
import '../screens/preference_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final tasks = taskProvider.tasks;
    final activeTasks = tasks
        .where((task) =>
            task.status != 'Completed' &&
                DateTime.now().isBefore(task.startDate) ||
            DateTime.now().isAtSameMomentAs(task.startDate))
        .toList();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 60, 8, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome User',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Total Tasks Remaining: ${activeTasks.length}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PreferenceScreen(),
                        ),
                      );
                    },
                    child: const CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/avatar.png'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Upcoming Tasks:',
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
              child: activeTasks.isNotEmpty
                  ? ListView.builder(
                      itemCount: activeTasks.length,
                      itemBuilder: (context, index) {
                        final task = activeTasks[index];
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
                        'No active tasks!',
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
