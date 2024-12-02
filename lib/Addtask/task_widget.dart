import 'package:flutter/material.dart';

class ContainerDatePicker extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(DateTime)? onDateSelected;

  const ContainerDatePicker({
    Key? key,
    required this.controller,
    required this.hintText,
    this.onDateSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Center(
      child: GestureDetector(
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2101),
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  colorScheme: ColorScheme.light(
                    primary: Colors.black,
                    onPrimary: Colors.white,
                    surface: Colors.white,
                    onSurface: Colors.black,
                  ),
                  dialogTheme: DialogTheme(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                child: child!,
              );
            },
          );

          if (pickedDate != null) {
            controller.text =
                '${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}';

            if (onDateSelected != null) {
              onDateSelected!(pickedDate);
            }
          }
        },
        child: AbsorbPointer(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border.all(color: Colors.black, width: screenWidth * 0.00080),
              borderRadius: BorderRadius.circular(8),
            ),
            height: screenHeight * 0.05,
            width: screenWidth * 0.8,
            child: Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.02),
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hintText,
                  suffixIcon: Icon(Icons.calendar_today,size: 20,),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a date';
                  }
                  return null;
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
