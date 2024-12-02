import 'package:flutter/material.dart';
import '../helper/code_text.dart';

class AppBarHelper {
  static AppBar buildAppBar({
    required String avatarImage,
    required String name,
    required String subName,
  }) {
    return AppBar(
      backgroundColor: AppRowprovider.darkPurple,
      title: Builder(
        builder: (context) {
          final screenWidth = MediaQuery.of(context).size.width;
          final avatarSize = screenWidth * 0.1;
          final spacing = screenWidth * 0.02;
          final fontSizeLarge = screenWidth * 0.05;
          final fontSizeSmall = screenWidth * 0.03;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              SizedBox(width: spacing),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: AppRowprovider.sageGreen,
                      fontSize: fontSizeLarge,
                      height: 1.0,
                    ),
                  ),
                  Text(
                    subName,
                    style: TextStyle(
                      color: AppRowprovider.sageGreen,
                      fontSize: fontSizeSmall,
                      height: 1.0,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
      actions: [
        Builder(
          builder: (context) {
            final iconSize = MediaQuery.of(context).size.width * 0.06;
            final spacing = MediaQuery.of(context).size.width * 0.02;

            return Row(
              children: [
                Icon(
                  Icons.notifications_active,
                  color: AppRowprovider.sageGreen,
                  size: iconSize,
                ),
                SizedBox(width: spacing),
              ],
            );
          },
        ),
      ],
    );
  }
}

class AddTaskButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final double height;
  final double width;
  final Alignment alignment; // Add alignment property

  const AddTaskButton({
    Key? key,
    required this.onPressed,
    this.backgroundColor = Colors.blue, // Default button color
    this.textColor = Colors.white, // Default text color
    this.iconColor = Colors.white, // Default icon color
    this.height = 50, // Default height
    this.width = 150, // Default width
    this.alignment = Alignment.center, // Default alignment
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment, // Align the button based on the property
      child: SizedBox(
        height: height,
        width: width,
        child: ElevatedButton.icon(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Rounded corners
            ),
          ),
          icon: Icon(
            Icons.add, // Plus icon
            size: 20,
            color: iconColor,
          ),
          label: Text(
            "Add Task",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}

class TaskListView extends StatelessWidget {
  final List<ValueNotifier<bool>> checkboxStates;

  const TaskListView({super.key, required this.checkboxStates});

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: MediaQuery.of(context).size.width * 0.06,
    );
    final subtextStyle = TextStyle(
      color: Colors.white,
      fontSize: MediaQuery.of(context).size.width * 0.02,
    );

    return Expanded(
      child: ListView.builder(
        itemCount: checkboxStates.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                checkboxStates[index].value = !checkboxStates[index].value;
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    ValueListenableBuilder<bool>(
                      valueListenable: checkboxStates[index],
                      builder: (context, isChecked, child) {
                        return Checkbox(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          value: isChecked,
                          onChanged: (value) {
                            checkboxStates[index].value = value!;
                          },
                        );
                      },
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Task ${index + 1}', style: textStyle),
                        Text('Details for Task ${index + 1}', style: subtextStyle),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
