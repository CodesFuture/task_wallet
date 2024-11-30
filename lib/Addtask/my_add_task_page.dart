  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  import 'package:provider/provider.dart';
  import 'package:task_wallet/Addtask/task_provider.dart';
  import 'package:task_wallet/Addtask/task_widget.dart';

  import '../Profile/my_profie_edit.dart';
  import '../Settings/setting_widgets.dart';
  import '../helper/code_text.dart';

  class AddTaskPage extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);
      final textProvider = Provider.of<TextProvider>(context);
      final buttonState = Provider.of<ButtonStateProvider>(context);
      final screenHeight = MediaQuery.of(context).size.height;
      final screenWidth = MediaQuery.of(context).size.width;

      return Scaffold(
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
                height: screenHeight * 0.63,
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
                        textProvider.getText('priority'),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      CompactPriorityDropdown(
                        priorityController: taskProvider.priorityController,
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
                        Navigator.pop(context); // Add this to dismiss the page
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
                          taskProvider.saveTask(context);

                        },
                        // onPressed: () {
                        //   if (widget.existingTask != null) {
                        //     taskProvider.updateTask(context, widget.existingTask!);
                        //   } else {
                        //     taskProvider.saveTask(context);
                        //   }
                        // },
                        child:Text(textProvider.getText('save'),)
                      // Text(
                      //   widget.existingTask != null
                      //       ? textProvider.getText('update')
                      //       : textProvider.getText('save'),
                      // ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

