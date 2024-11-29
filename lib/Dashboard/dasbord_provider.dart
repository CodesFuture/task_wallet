import 'package:flutter/foundation.dart';

class TaskProvider extends ChangeNotifier {
  int totalTasks = 0;
  int completedTasks = 0;
  int pendingTasks = 0;
  List<Task> recentTasks = [];

  void initializeTasks() {
    List<Task> tasks = [
      Task(
        id: "1",
        title: "Task 1",
        description: "This is the first task",
        priority: "High",
        dueDate: "2024-12-01",
        assignedTo: "John Doe",
      ),
      Task(
        id: "2",
        title: "Task 2",
        description: "This is the second task",
        status: "Completed",
        priority: "Medium",
        dueDate: "2024-12-05",
        assignedTo: "Jane Doe",
      ),
      Task(
        id: "3",
        title: "Task 3",
        description: "This is the third task",
        priority: "Low",
        dueDate: "2024-12-10",
        assignedTo: "Alice",
      ),
    ];

    // Add tasks to the list
    recentTasks.addAll(tasks);

    // Update counts
    totalTasks = tasks.length;
    completedTasks = tasks.where((task) => task.status == "Completed").length;
    pendingTasks = tasks.where((task) => task.status == "Pending").length;
    notifyListeners();
  }

  // Add a new task
  void addTask(Task task) {
    recentTasks.add(task);
    totalTasks++;
    if (task.status == "Pending") pendingTasks++;
    else if (task.status == "Completed") completedTasks++;
    notifyListeners();
  }

  void completeTask(String taskId) {
    final task = recentTasks.firstWhere((t) => t.id == taskId);
    if (task.status != "Completed") {
      task.status = "Completed";
      completedTasks++;
      pendingTasks--;
      notifyListeners();
    }
  }

  void deleteTask(String taskId) {
    final task = recentTasks.firstWhere((t) => t.id == taskId, orElse: () => throw Exception("Task not found"));
    if (task.status == "Pending") pendingTasks--;
    if (task.status == "Completed") completedTasks--;
    recentTasks.remove(task);
    totalTasks--;
    notifyListeners();
  }

  void editTask(String taskId, {String? title, String? description, String? priority}) {
    final task = recentTasks.firstWhere((t) => t.id == taskId, orElse: () => throw Exception("Task not found"));
    if (title != null) task.title = title;
    if (description != null) task.description = description;
    if (priority != null) task.priority = priority;
    notifyListeners();
  }
}

class Task {
  String id;
  String title;
  String description;
  String status; // e.g., "Pending", "Completed"
  String priority; // e.g., "High", "Medium", "Low"
  String dueDate;
  String assignedTo;

  Task({
    required this.id,
    required this.title,
    required this.description,
    this.status = "Pending",
    required this.priority,
    required this.dueDate,
    required this.assignedTo,
  });
}
