import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ButtonStateProvider with ChangeNotifier {
  bool _isCancelSelected = true;

  // Getter for the state
  bool get isCancelSelected => _isCancelSelected;

  // Method to update the state
  void selectCancel() {
    _isCancelSelected = true;
    notifyListeners();
  }

  void selectSave() {
    _isCancelSelected = false;
    notifyListeners();
  }
}

class DatePickerProvider with ChangeNotifier {
  DateTime? _selectedDate;
  final TextEditingController _dateController = TextEditingController();

  // Getters
  DateTime? get selectedDate => _selectedDate;
  TextEditingController get dateController => _dateController;

  // Set the selected date and update the controller
  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    _dateController.text = DateFormat('dd-MM-yyyy').format(date);
    notifyListeners(); // Notify listeners to rebuild the UI
  }

  // Optionally clear the date
  void clearDate() {
    _selectedDate = null;
    _dateController.clear();
    notifyListeners();
  }
}