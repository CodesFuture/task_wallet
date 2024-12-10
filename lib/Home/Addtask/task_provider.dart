import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../Database/database_model.dart';
import '../../Database/database_service.dart';

class TaskProvider extends ChangeNotifier {
  final TextEditingController taskTitleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priorityController = TextEditingController();
  final TextEditingController assigneeController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TaskDatabase _database = TaskDatabase.instance;
  List<Task> _tasks = [];

  List<Task> get recentTasks => _tasks.take(20).toList();

  Future<void> initializeTasks() async {
    try {
      _tasks = await _database.getAllTasks();
      notifyListeners();
    } catch (e) {
      debugPrint('Error initializing tasks: $e');
    }
  }

  TimeOfDay parseTime(String timeText) {
    final timeparts = timeText.split(':');
    return TimeOfDay(
      hour: int.parse(
        timeparts[0],
      ),
      minute: int.parse(
        timeparts[1],
      ),
    );
  }

  Future<bool> saveTask(BuildContext context) async {
    if (!validateTaskFields(context)) {
      return false;
    }
    try {
      final task = Task(
          taskTitle: taskTitleController.text.trim(),
          description: descriptionController.text.trim(),
          dueDate: dateController.text.trim(),
          priority: priorityController.text.trim(),
          assignee: assigneeController.text.trim(),
          status: 'Complete',
          time: parseTime(timeController.text));

      await _database.create(task);
      _tasks.insert(0, task);
      notifyListeners();

      taskTitleController.clear();
      descriptionController.clear();
      priorityController.clear();
      assigneeController.clear();
      dateController.clear();
      timeController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Task saved successfully')),
      );
      return true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save task: $e')),
      );
      return false;
    }
  }

  Future<void> updateTask(BuildContext context, Task existingTask) async {
    if (!validateTaskFields(context)) {
      return;
    }

    try {
      Task updatedTask = Task(
          taskId: existingTask.taskId,
          taskTitle: taskTitleController.text.trim(),
          description: descriptionController.text.trim(),
          dueDate: dateController.text.trim(),
          priority: priorityController.text.trim(),
          assignee: assigneeController.text.trim(),
          status: existingTask.status,
          time: parseTime(timeController.text));

      int rowsAffected = await _database.update(updatedTask);
      if (rowsAffected > 0) {
        int index =
            _tasks.indexWhere((task) => task.taskId == existingTask.taskId);
        if (index != -1) {
          _tasks[index] = updatedTask;
          notifyListeners();
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Task updated successfully'),
            duration: Duration(seconds: 2),
          ),
        );

        // Clear controllers
        taskTitleController.clear();
        descriptionController.clear();
        priorityController.clear();
        assigneeController.clear();
        dateController.clear();
        timeController.clear();

        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Task update failed'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating task: $e'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  bool validateTaskFields(BuildContext context) {
    if (taskTitleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Task title is required')),
      );
      return false;
    }
    if (descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Description is required')),
      );
      return false;
    }
    if (dateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Due date is required')),
      );
      return false;
    }
    if (priorityController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Priority is required')),
      );
      return false;
    }
    if (assigneeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Assignee is required')),
      );
      return false;
    }
    return true;
  }

  void clearAllControllers() {
    taskTitleController.clear();
    descriptionController.clear();
    priorityController.clear();
    assigneeController.clear();
    dateController.clear();
    timeController.clear();
    notifyListeners();
  }

  void setPriority(String priority) {
    priorityController.text = priority;
    notifyListeners();
  }

  @override
  void disposes() {
    taskTitleController.dispose();
    descriptionController.dispose();
    priorityController.dispose();
    assigneeController.dispose();
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }
}

class ButtonStateProvider with ChangeNotifier {
  bool _isCancelSelected = true;

  bool get isCancelSelected => _isCancelSelected;

  void selectCancel() {
    _isCancelSelected = true;
    notifyListeners();
  }

  void selectSave() {
    _isCancelSelected = false;
    notifyListeners();
  }
}

class DatePickerProvider with ChangeNotifier {
  DateTime? _selectedDate;
  final TextEditingController _dateController = TextEditingController();

  DateTime? get selectedDate => _selectedDate;

  TextEditingController get dateController => _dateController;

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    _dateController.text = DateFormat('dd-MM-yyyy').format(date);
    notifyListeners();
  }

  void clearDate() {
    _selectedDate = null;
    _dateController.clear();
    notifyListeners();
  }
}
