import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../helper/code_text.dart';
import 'profile_helper.dart';
import 'my_profie_edit.dart';

class TextInputField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  TextInputField({required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          height: screenHeight * 0.05,
          width: screenWidth * 0.8,
          padding: EdgeInsets.only(left: screenWidth * 0.02),
          alignment: Alignment.centerLeft,
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration.collapsed(
              hintText: hintText,
              hintStyle: TextStyle(fontSize: 15),
            ),
          ),
        ),
      ),
    );
  }
}

class DropdownInputField extends StatelessWidget {
  final String? value;
  final List<String> items;
  final String hint;
  final ValueChanged<String?> onChanged;

  DropdownInputField({
    required this.value,
    required this.items,
    required this.hint,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          height: screenHeight * 0.05,
          width: screenWidth * 0.8,
          padding: EdgeInsets.only(left: screenWidth * 0.02),
          alignment: Alignment.centerLeft,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              hint: Align(
                alignment: Alignment.centerLeft,
                child: Text(hint),
              ),
              items: items
                  .map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      ))
                  .toList(),
              onChanged: onChanged,
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down),
            ),
          ),
        ),
      ),
    );
  }
}

class NotificationCheckbox extends StatelessWidget {
  final bool value;
  final String label;
  final ValueChanged<bool?> onChanged;

  NotificationCheckbox({
    required this.value,
    required this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        constraints: BoxConstraints.tightFor(height: screenHeight * 0.04),
        // Adjusted height dynamically
        child: Row(
          children: [
            Checkbox(
              value: value,
              onChanged: onChanged,
            ),
            Text(label),
          ],
        ),
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isCancelSelected = false;
  bool isEmailNotificationEnabled = false;
  bool isTaskDueReminderEnabled = false;
  String? selectedTimezone;
  String? seectedlanguage;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final textProvider = Provider.of<TextProvider>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenHeight * 0.02,
                    vertical: screenWidth * 0.02),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      textProvider.getText('profile'),
                      style: TextStyle(
                        fontSize: screenWidth * 0.07,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Material(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            navigateWithSlideTransition(
                                context, ProfileEditPage());
                          },
                          child: Container(
                            height: screenHeight * 0.04,
                            width: screenWidth * 0.25,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.edit_outlined,
                                  size: 15,
                                ),
                                Text("Edit Profile"),
                              ],
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.015),
              Center(
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    height: screenHeight * 0.63,
                    width: screenWidth * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            textProvider.getText('personalinfo'),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        customPaddedText(
                          leftPaddingFactor: 0.05,
                          text: textProvider.getText('textname'),
                          screenWidth: screenWidth,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        customPaddedText(
                          leftPaddingFactor: 0.05,
                          text: textProvider.getText('hintname'),
                          screenWidth: screenWidth,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        customPaddedText(
                          leftPaddingFactor: 0.05,
                          text: textProvider.getText('hintname'),
                          screenWidth: screenWidth,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        customPaddedText(
                          leftPaddingFactor: 0.05,
                          text: textProvider.getText('textemail'),
                          screenWidth: screenWidth,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            textProvider.getText('preference'),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        customPaddedText(
                          leftPaddingFactor: 0.05,
                          text: textProvider.getText('language'),
                          screenWidth: screenWidth,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        customPaddedText(
                          leftPaddingFactor: 0.05,
                          text: textProvider.getText('hintemail'),
                          screenWidth: screenWidth,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        customPaddedText(
                          leftPaddingFactor: 0.05,
                          text: textProvider.getText('language'),
                          screenWidth: screenWidth,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        customPaddedText(
                          leftPaddingFactor: 0.05,
                          text: textProvider.getText('hintemail'),
                          screenWidth: screenWidth,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            textProvider.getText('notesetting'),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: screenWidth * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        NotificationCheckbox(
                          value: isEmailNotificationEnabled,
                          label: textProvider.getText('emailnote'),
                          onChanged: (value) {
                            setState(() {
                              isEmailNotificationEnabled = value!;
                            });
                          },
                        ),
                        NotificationCheckbox(
                          value: isTaskDueReminderEnabled,
                          label: textProvider.getText('taskreminder'),
                          onChanged: (value) {
                            setState(() {
                              isTaskDueReminderEnabled = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
