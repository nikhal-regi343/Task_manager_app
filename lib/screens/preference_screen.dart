import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/providers/task_provider.dart';

class PreferenceScreen extends StatelessWidget {
  const PreferenceScreen({super.key});

  @override
  Widget build(context) {
    final themeProvider = Provider.of<TaskProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preference Screen"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: themeProvider.themeMode == ThemeMode.dark,
            onChanged: (value) {
              themeProvider.toggleTheme(value);
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Sorting Order',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: themeProvider.currentSortCriterion,
                  items: const [
                    DropdownMenuItem(value: 'status', child: Text('Status')),
                    DropdownMenuItem(value: 'date', child: Text('Date')),
                    DropdownMenuItem(
                        value: 'priority', child: Text('Priority')),
                  ],
                  onChanged: (value) async {
                    if (value != null) {
                      await themeProvider.setDefaultSortCriterion(value);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
