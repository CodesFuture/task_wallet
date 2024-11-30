import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:task_wallet/Addtask/task_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class ContainerDatePicker extends StatelessWidget {
  final String hintText;
  final TextEditingController controller; // Add a controller property

  ContainerDatePicker({
    Key? key,
    this.hintText = 'Select Date',
    required this.controller, // Make it required
  }) : super(key: key);

  // Method to open the custom date picker dialog
  void openCustomDatePicker(BuildContext context) {
    final datePickerProvider = Provider.of<DatePickerProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (_) {
        final mediaQuery = MediaQuery.of(context);

        return AlertDialog(
          title: const Text('Select Date'),
          content: SizedBox(
            height: mediaQuery.size.height * 0.4,
            child: CalendarDatePicker(
              initialDate: datePickerProvider.selectedDate ?? DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2025, 12),
              onDateChanged: (date) {
                datePickerProvider.setSelectedDate(date);
                controller.text = date.toLocal().toString().split(' ')[0];
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Set'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;

    return GestureDetector(
      onTap: () => openCustomDatePicker(context),
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          height: screenHeight * 0.05,
          width: screenWidth * 0.8,
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  controller.text.isEmpty ? hintText : controller.text,
                  style: TextStyle(
                    color: controller.text.isEmpty ? Colors.grey : Colors.black,
                  ),
                ),
              ),
              Icon(Icons.calendar_today, color: Colors.grey, size: screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
