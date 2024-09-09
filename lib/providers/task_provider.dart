import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../service/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskProvider with ChangeNotifier {
  List<TaskModel> _tasks = [];

  List<TaskModel> get tasks {
    _tasks.sort((a, b) {
      switch (_currentSortCriterion) {
        case 'status':
          return a.status.compareTo(b.status);
        case 'date':
          return a.startDate.compareTo(b.startDate);
        case 'priority':
          return _priorityValue(a.priority)
              .compareTo(_priorityValue(b.priority));
        default:
          return 0;
      }
    });
    return _tasks;
  }

  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  bool _darkMode = false;
  bool get darkMode => _darkMode;

  String _currentSortCriterion = 'date';
  String get currentSortCriterion => _currentSortCriterion;

  TaskProvider() {
    _loadTheme();
    _loadSortingPreference();
  }

  Future<void> setDefaultSortCriterion(String order) async {
    _currentSortCriterion = order;
    await _saveSortingPreference(order);
    sortTasksBy(order);
    notifyListeners();
  }

  Future<void> _saveSortingPreference(String order) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('SortCriterion', order);
  }

  Future<void> _loadSortingPreference() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedCriterion = prefs.getString('SortCriterion');
    // if (savedCriterion != null) {
    _currentSortCriterion = savedCriterion!;
    sortTasksBy(_currentSortCriterion);
    // }
  }

  void toggleTheme(bool darkMode) async {
    _darkMode = darkMode;
    _themeMode = darkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('DarkMode', darkMode);
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _darkMode = prefs.getBool('DarkMode') ?? false;
    _themeMode = _darkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> fetchTasks() async {
    _tasks = await DatabaseHelper().getTasks();
    notifyListeners();
  }

  Future<void> addTask(TaskModel task) async {
    await DatabaseHelper().insertTask(task);
    await fetchTasks();
    notifyListeners();
  }

  Future<void> updateTask(TaskModel task) async {
    await DatabaseHelper().updateTask(task);
    await fetchTasks();
    notifyListeners();
  }

  void updateTaskStatus(int taskId, String newStatus) async {
    TaskModel task = _tasks.firstWhere((task) => task.id == taskId);
    task.status = newStatus;
    await DatabaseHelper().updateTask(task);
    await fetchTasks();
    notifyListeners();
  }

  Future<void> deleteTask(int id) async {
    await DatabaseHelper().deleteTask(id);
    await fetchTasks();
    notifyListeners();
  }

  void sortTasksBy(String criterion) {
    switch (criterion) {
      case 'status':
        _tasks.sort((a, b) => a.status.compareTo(b.status));
        break;
      case 'date':
        _tasks.sort((a, b) => a.startDate.compareTo(b.startDate));
        break;
      case 'priority':
        _tasks.sort((a, b) =>
            _priorityValue(a.priority).compareTo(_priorityValue(b.priority)));
        break;
      default:
        break;
    }
    notifyListeners();
  }

  int _priorityValue(String priority) {
    switch (priority) {
      case 'High':
        return 1;
      case 'Medium':
        return 2;
      case 'Low':
        return 3;
      default:
        return 4;
    }
  }
}
