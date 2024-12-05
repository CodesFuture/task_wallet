import 'package:flutter/material.dart';

//ProfileHeader Widget://
class ProfileHeader extends StatelessWidget {
  final String title;
  final double screenWidth;

  ProfileHeader({required this.title, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: screenWidth * 0.7),
      child: Text(
        title,
        style: TextStyle(
          fontSize: screenWidth * 0.07,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

//CustomTextField Widget://
class CustomTextField extends StatelessWidget {
  final String hintText;
  final double screenHeight;
  final double screenWidth;

  CustomTextField({
    required this.hintText,
    required this.screenHeight,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
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
            decoration: InputDecoration.collapsed(
                hintText: hintText, hintStyle: TextStyle(fontSize: 15)),
          ),
        ),
      ),
    );
  }
}

//CustomDropdown Widget://
class CustomDropdown extends StatelessWidget {
  final String? selectedValue;
  final List<String> items;
  final Function(String?) onChanged;
  final String hintText;

  CustomDropdown({
    required this.selectedValue,
    required this.items,
    required this.onChanged,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        elevation: 1,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          height: 50,
          width: 300,
          padding: EdgeInsets.only(left: 10),
          alignment: Alignment.centerLeft,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedValue,
              hint: Align(
                alignment: Alignment.centerLeft,
                child: Text(hintText, style: TextStyle(color: Colors.black)),
              ),
              items: items
                  .map((lang) => DropdownMenuItem(
                        value: lang,
                        child:
                            Text(lang, style: TextStyle(color: Colors.black)),
                      ))
                  .toList(),
              onChanged: onChanged,
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down, color: Colors.black),
              alignment: Alignment.centerRight,
            ),
          ),
        ),
      ),
    );
  }
}

//CustomCheckbox Widget://
class CustomCheckbox extends StatelessWidget {
  final bool value;
  final Function(bool?) onChanged;
  final String label;

  CustomCheckbox({
    required this.value,
    required this.onChanged,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: Container(
        constraints: BoxConstraints.tightFor(height: 30),
        child: Row(
          children: [
            Checkbox(value: value, onChanged: onChanged),
            Text(label),
          ],
        ),
      ),
    );
  }
}

//Text Helper//
Widget customPaddedText({
  required double leftPaddingFactor,
  required String text,
  required double screenWidth,
  TextStyle? style,
}) {
  return Padding(
    padding: EdgeInsets.only(left: screenWidth * leftPaddingFactor),
    child: Text(
      text,
      style: style ?? const TextStyle(fontSize: 16),
    ),
  );
}

// Navigation Helper//


void navigateWithSlideTransition(BuildContext context, Widget page) {
  Navigator.push(
    context,
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const offsetBegin = Offset(1.0, 0.0);
        const offsetEnd = Offset.zero;

        var tween = Tween(begin: offsetBegin, end: offsetEnd);
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
    ),
  );
}
