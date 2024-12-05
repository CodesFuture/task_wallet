import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:task_wallet/helper/code_text.dart';
import '../Addtask/my_add_task_page.dart';
import '../Addtask/task_provider.dart';
import '../Database/database_service.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<TaskProvider>(context, listen: false).initializeTasks();

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            SizedBox(height: screenHeight * 0.02),
            buildTaskOverview(context, screenHeight, screenWidth),
            SizedBox(height: screenHeight * 0.02),
            buildRecentTasks(context, screenHeight, screenWidth),
          ],
        ),
      ),
    );
  }

  Widget buildTaskOverview(
      BuildContext context, double screenHeight, double screenWidth) {
    final provider = Provider.of<TaskProvider>(context);

    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(25),
      child: Container(
        height: screenHeight * 0.22,
        width: screenWidth * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(right: screenWidth * 0.43),
              child: Text(
                "Task Overview",
                style: TextStyle(
                    fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold),
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     taskStat(provider.totalTasks.toString(), "Total Tasks", screenWidth),
            //     taskStat(provider.completedTasks.toString(), "Completed", screenWidth),
            //     taskStat(provider.pendingTasks.toString(), "Pending", screenWidth),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Widget taskStat(String count, String label, double screenWidth) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
              fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style:
              TextStyle(fontSize: screenWidth * 0.035, color: Colors.grey[600]),
        ),
      ],
    );
  }

  Widget buildRecentTasks(
      BuildContext context, double screenHeight, double screenWidth) {
    final provider = Provider.of<TaskProvider>(context);

    return Center(
      child: Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(25),
        child: Container(
          height: screenHeight * 0.6,
          width: screenWidth * 0.9,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(right: screenWidth * 0.43),
                child: Text(
                  "Recent Tasks",
                  style: TextStyle(
                      fontSize: screenWidth * 0.05,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Expanded(
                child: provider.recentTasks.isEmpty
                    ? Center(child: Text("No recent tasks available."))
                    : ListView.builder(
                        itemCount: provider.recentTasks.length,
                        itemBuilder: (context, index) {
                          final task = provider.recentTasks[index];
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: screenWidth * 0.02,
                              horizontal: screenHeight * 0.02,
                            ),
                            child: Slidable(
                              startActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  // Edit action
                                  SlidableAction(
                                    onPressed: (context) {
                                      // Navigate to AddTaskPage with the existing task
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AddTaskPage(existingTask: task),
                                        ),
                                      );
                                    },
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                    icon: Icons.edit,
                                    label: 'Edit',
                                  ),
                                ],
                              ),
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  // Delete action
                                  SlidableAction(
                                    onPressed: (context) async {
                                      if (task.taskId != null) {
                                        try {
                                          int rowsAffected = await TaskDatabase.instance.delete(task.taskId!);

                                          if (rowsAffected > 0) {
                                            provider.recentTasks.remove(task);

                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text('Task deleted successfully'),
                                                duration: Duration(seconds: 2),
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text('Failed to delete task'),
                                                backgroundColor: Colors.red,
                                                duration: Duration(seconds: 2),
                                              ),
                                            );
                                          }
                                        } catch (e) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('Error deleting task: $e'),
                                              backgroundColor: Colors.red,
                                              duration: Duration(seconds: 2),
                                            ),
                                          );
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Cannot delete task: No ID found'),
                                            backgroundColor: Colors.red,
                                            duration: Duration(seconds: 2),
                                          ),
                                        );
                                      }
                                    },
                                    backgroundColor: Colors.red,
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    label: 'Delete',
                                  ),
                                ],
                              ),
                              child: Container(
                                height: screenHeight * 0.11,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: AppRowprovider.black,width: screenWidth * 0.00080)
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            task.taskTitle,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(width: screenWidth * 0.02),
                                          statusLabel(task.status,
                                              screenHeight, screenWidth),
                                          SizedBox(width: screenWidth * 0.02),
                                          priorityLabel(task.priority,
                                              screenHeight, screenWidth),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(task.description),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.calendar_month,
                                              size: 12),
                                          Text(
                                            task.dueDate,
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.black),
                                          ),
                                          SizedBox(width: screenWidth * 0.02),
                                          Icon(Icons.perm_identity, size: 12),
                                          Text(
                                            task.assignee,
                                            style: TextStyle(fontSize: 10),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget statusLabel(String status, double screenHeight, double screenWidth) {
    return Container(
      height: screenHeight * 0.02,
      width: screenWidth * 0.12,
      decoration: BoxDecoration(
        color: status.toLowerCase() == "completed" ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(5),
      ),
      alignment: Alignment.center,
      child: Text(
        status,
        style: TextStyle(
          color: Colors.white,
          fontSize: screenWidth * 0.02,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget priorityLabel(
      String priority, double screenHeight, double screenWidth) {
    return Container(
      height: screenHeight * 0.02,
      width: screenWidth * 0.12,
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(5),
      ),
      alignment: Alignment.center,
      child: Text(
        priority,
        style: TextStyle(
          color: Colors.white,
          fontSize: screenWidth * 0.02,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
