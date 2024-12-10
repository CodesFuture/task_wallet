// Future<void> updateTask(BuildContext context, Task existingTask) async {
//   if (validateTaskFields()) {
//     try {
//       Task updatedTask = Task(
//         id: existingTask.id,
//         taskTitle: taskTitleController.text,
//         description: descriptionController.text,
//         dueDate: dateController.text,
//         priority: priorityController.text,
//         assignee: assigneeController.text,
//         status: existingTask.status, // Preserve existing status
//       );
//
//       // Call database update method
//       int rowsAffected = await TaskDatabase.instance.update(updatedTask);
//
//       if (rowsAffected > 0) {
//         // Update the task in the list
//         int index = recentTasks.indexWhere((task) => task.id == existingTask.id);
//         if (index != -1) {
//           recentTasks[index] = updatedTask;
//           notifyListeners(); // Important to update the UI
//         }
//
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Task updated successfully'),
//             duration: Duration(seconds: 2),
//           ),
//         );
//         Navigator.pop(context);
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error updating task: $e'),
//           backgroundColor: Colors.red,
//           duration: Duration(seconds: 2),
//         ),
//       );
//     }
//   }
// }  Future<void> initializeTasks() async {
//   try {
//     _tasks = await _database.getAllTasks();
//     notifyListeners();
//   } catch (e) {
//     debugPrint('Error initializing tasks: $e');
//   }
// }