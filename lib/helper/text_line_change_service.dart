import 'package:flutter/material.dart';
class AutoWrapText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final int breakPoint;

  const AutoWrapText({
    Key? key,
    required this.text,
    this.style,
    this.breakPoint = 25,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Split the text into words
    final words = text.split(' ');
    List<String> lines = [];
    String currentLine = '';

    // Process each word
    for (var word in words) {
      // If adding this word would exceed the breakpoint
      if ((currentLine + ' ' + word).length > breakPoint && currentLine.isNotEmpty) {
        lines.add(currentLine.trim());
        currentLine = word;
      } else {
        // Add space only if it's not the first word in the line
        if (currentLine.isNotEmpty) {
          currentLine += ' ';
        }
        currentLine += word;
      }
    }

    // Add the last line if not empty
    if (currentLine.isNotEmpty) {
      lines.add(currentLine.trim());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: lines.map((line) => Text(
        line,
        style: style,
      )).toList(),
    );
  }
}