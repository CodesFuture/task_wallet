import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_wallet/Home/Addtask/task_provider.dart';
import 'package:task_wallet/Home/Addtask/task_widget.dart';
import '../../Database/database_model.dart';
import '../../helper/code_text.dart';
import '../Profile/my_profie_edit.dart';

class AddTaskPage extends StatelessWidget {
  final Task? existingTask;

  const AddTaskPage({Key? key, this.existingTask}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    final textProvider = Provider.of<TextProvider>(context);
    final buttonState = Provider.of<ButtonStateProvider>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    if (existingTask != null) {
      taskProvider.taskTitleController.text = existingTask!.taskTitle;
      taskProvider.descriptionController.text = existingTask!.description;
      taskProvider.dateController.text = existingTask!.dueDate;
      taskProvider.priorityController.text = existingTask!.priority;
      taskProvider.assigneeController.text = existingTask!.assignee;
      taskProvider.timeController.text = '${existingTask!.time.hour}:${existingTask!.time.minute}'; // Set time in text format
    }

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenHeight * 0.02,
                  vertical: screenWidth * 0.02,
                ),
                child: Row(
                  children: [
                    Text(
                      textProvider.getText('Taskpage'),
                      style: TextStyle(
                        fontSize: screenWidth * 0.07,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.015),
              Container(
                height: screenHeight * 0.7,
                width: screenWidth * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.task_alt_outlined,
                              size: screenHeight * 0.025),
                          SizedBox(width: screenWidth * 0.02),
                          Text(
                            textProvider.getText('AddTask'),
                            style: TextStyle(
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        textProvider.getText('Tasktitle'),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextInputField(
                        hintText: textProvider.getText('EnterTasktitle'),
                        controller: taskProvider.taskTitleController,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        textProvider.getText('description'),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextInputField(
                        hintText: textProvider.getText('EnterTaskdescription'),
                        controller: taskProvider.descriptionController,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        textProvider.getText('duedate'),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      ContainerDatePicker(
                        controller: taskProvider.dateController,
                        hintText: textProvider.getText('selecteddate'),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        textProvider.getText('time'),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final TimeOfDay? timeOfDay = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                            builder: (BuildContext context, Widget? child) {
                              return Theme(
                                data: ThemeData(
                                  colorScheme: ColorScheme.light(
                                    primary: Colors.black, // Header background color
                                    onPrimary: Colors.white, // Header text color
                                    surface: Colors.white, // Dialog background color
                                    onSurface: Colors.black, // Time text color
                                  ),
                                  dialogBackgroundColor: Colors.white, // Dialog background
                                ),
                                child: child!,
                              );
                            },
                          );

                          if (timeOfDay != null) {
                            taskProvider.timeController.text = timeOfDay.format(context);
                          }
                        },
                        child: AbsorbPointer(
                          child: TextInputField(
                            hintText: textProvider.getText('selecttime'),
                            controller: taskProvider.timeController,
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        textProvider.getText('assignee'),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextInputField(
                        hintText: textProvider.getText('enterassignee'),
                        controller: taskProvider.assigneeController,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Consumer<TaskProvider>(
                        builder: (context, taskProvider, child) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _PriorityCheckbox(
                                text: 'Low',
                                isSelected:
                                taskProvider.priorityController.text == 'Low',
                              ),
                              _PriorityCheckbox(
                                text: 'Medium',
                                isSelected:
                                taskProvider.priorityController.text == 'Medium',
                              ),
                              _PriorityCheckbox(
                                text: 'High',
                                isSelected:
                                taskProvider.priorityController.text == 'High',
                              ),
                            ],
                          );
                        },
                      ),
                      SizedBox(height: screenHeight * 0.02),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenHeight * 0.02,
                  vertical: screenWidth * 0.02,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonState.isCancelSelected
                            ? Colors.black
                            : Colors.white,
                        foregroundColor: buttonState.isCancelSelected
                            ? Colors.white
                            : Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: const BorderSide(color: Colors.black),
                      ),
                      onPressed: () {
                        buttonState.selectCancel();
                        existingTask != null
                            ? Navigator.pop(context)
                            : taskProvider.clearAllControllers();
                      },
                      child: Text(
                        textProvider.getText('cancel'),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonState.isCancelSelected
                            ? Colors.white
                            : Colors.black,
                        foregroundColor: buttonState.isCancelSelected
                            ? Colors.black
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        side: const BorderSide(color: Colors.black),
                      ),
                      onPressed: () {
                        if (existingTask != null) {
                          taskProvider.updateTask(context, existingTask!);
                        } else {
                          taskProvider.saveTask(context);
                        }
                      },
                      child: Text(
                        existingTask != null
                            ? textProvider.getText('update')
                            : textProvider.getText('save'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PriorityCheckbox extends StatelessWidget {
  final String text;
  final bool isSelected;

  const _PriorityCheckbox({
    required this.text,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<TaskProvider>(context, listen: false).setPriority(text);
      },
      child: Row(
        children: [
          Checkbox(
            activeColor: AppRowprovider.black,
            value: isSelected,
            onChanged: (_) {
              Provider.of<TaskProvider>(context, listen: false)
                  .setPriority(text);
            },
          ),
          Text(text),
        ],
      ),
    );
  }
}
