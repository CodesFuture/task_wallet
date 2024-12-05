import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../helper/code_text.dart';

class TextInputField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  TextInputField({required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: AppRowprovider.black, width: screenWidth * 0.00080),
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
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: AppRowprovider.black, width: screenWidth * 0.00080),
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

class ProfileEditPage extends StatefulWidget {
  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
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
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [

              Padding(
                padding: EdgeInsets.only(right: screenWidth * 0.7),
                child: Text(
                  textProvider.getText('profile'),
                  style: TextStyle(
                    fontSize: screenWidth * 0.07,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.025),
              Center(
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(15),
                  child: Container(
                    height: screenHeight * 0.65,
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
                        Padding(
                          padding: EdgeInsets.only(left: screenWidth * 0.05),
                          child: Text(
                            textProvider.getText('textname'),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextInputField(
                          hintText: textProvider.getText('hintname'),
                          controller: fullNameController,
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Padding(
                          padding: EdgeInsets.only(left: screenWidth * 0.05),
                          child: Text(
                            textProvider.getText('textemail'),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextInputField(
                          hintText: textProvider.getText('hintemail'),
                          controller: emailController,
                        ),
                        SizedBox(height: screenHeight * 0.01),
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
                        Padding(
                          padding: EdgeInsets.only(left: screenWidth * 0.05),
                          child: Text(
                            textProvider.getText('language'),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DropdownInputField(
                          value: seectedlanguage,
                          items: GlobalLanguage.language,
                          hint: textProvider.getText('selectednguage'),
                          onChanged: (value) {
                            setState(() {
                              seectedlanguage = value;
                            });
                          },
                        ),
                        SizedBox(height: screenHeight * 0.02),
                        Padding(
                          padding: EdgeInsets.only(left: screenWidth * 0.05),
                          child: Text(
                            textProvider.getText('timezon'),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DropdownInputField(
                          value: selectedTimezone,
                          items: GlobalData.timezones,
                          hint: textProvider.getText('selectedtimezon'),
                          onChanged: (value) {
                            setState(() {
                              selectedTimezone = value;
                            });
                          },
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
              SizedBox(height: screenHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      child: SizedBox(
                    width: screenWidth * 0.46,
                  )),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isCancelSelected ? Colors.white : Colors.black,
                      foregroundColor:
                          isCancelSelected ? Colors.black : Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: BorderSide(color: Colors.black),
                    ),
                    onPressed: () {
                      setState(() {
                        isCancelSelected = false;
                        Navigator.pop(context);
                      });
                    },
                    child: Text(
                      textProvider.getText('cancel'),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          isCancelSelected ? Colors.black : Colors.white,
                      foregroundColor:
                          isCancelSelected ? Colors.white : Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      side: BorderSide(color: Colors.black),
                    ),
                    onPressed: () {
                      setState(() {
                        isCancelSelected = true;
                        Navigator.pop(context);
                      });
                    },
                    child: Text(
                      textProvider.getText('save'),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
