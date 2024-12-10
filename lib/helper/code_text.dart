import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRowprovider with ChangeNotifier {
  // Original Colors
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey300 = Color(0xFFE0E0E0);
  static const Color brightYellow = Color(0xFFFFB100);
  static const Color softOrange = Color(0xFFFBC252);
  static const Color lightCream = Color(0xFFF0EBE3);
  static const Color sageGreen = Color(0xFFA3BB98);
//Best Combination
//   static const Color lightCream = Color(0xFFF0ECCF);
  static const Color deepTeal = Color(0xFFE3A92D); // Best combination

  // New Colors
  static const Color deepPink = Color(0xFFE23E57);
  static const Color plumRed = Color(0xFF88304E);
  static const Color darkPurple = Color(0xFF522546);
  static const Color midnightPurple = Color(0xFF311D3F);

  // All Colors List
  static const List<Color> allColors = [
    brightYellow,
    softOrange,
    lightCream,
    sageGreen,
    deepPink,
    plumRed,
    darkPurple,
    midnightPurple,
  ];
}

class ImageAssets {
  static const String avatarPlaceholder = "asserts/image/placeholder.jpg";
}

class TextProvider with ChangeNotifier {
  // Define initial texts
  Map<String, String> texts = {
    'name': "Mohit",
    'subname': "Good Morning",
    'username': "Username",
    'password': "Password",
    'email': "Email",
    'phoneNumber': "Phone Number",
    'login': "Login",
    'register': "Register",
    'submit': "Submit",
    'cancel': "Cancel",
    'usernameRequired': "Username is required.",
    'passwordRequired': "Password is required.",
    'invalidEmail': "Please enter a valid email address.",
    'phoneRequired': "Phone number is required.",
    'loginSuccess': "Login successful!",
    'registrationSuccess': "Registration completed successfully.",
    'welcomeMessage': "Welcome to MyApp!",
    'forgotPassword': "Forgot Password?",
    'termsAndConditions': "By continuing, you agree to the Terms & Conditions.",
    'searchPlaceholder': "Search...",
    'enterMessage': "Enter your message here...",
    'profile': "Profile",
    'personalinfo': "Personal Information",
    'textname': "Full name",
    'hintname': "Your Full Name",
    'textemail': "Email Address",
    'hintemail': "Email@gmail.com",
    'preference': "Preferences",
    'language': "Language",
    'selectednguage': "Select Language",
    'timezon': "Timezone",
    'selectedtimezon': "Select Timezone",
    'notesetting': "Notification Settings",
    'emailnote': "Email Notifications",
    'taskreminder': "Task Due Reminders",
    'save': "Save",
    'settings': "Settings",
    'settingspref': "Manage your app settings",
    'appearance': "Appearance",
    'Theme': "Theme",
    'Light':"Light",
    'Dark':"Dark",
    'Thememode': "Choose your theme",
    'CompactView': "Compact View",
    'CompactDispay': "Display content layout",
    'notifications': "Notifications",
    'DailyDigest': "Daily Digest",
    'Receivetasks': "Receive a daily summary of your tasks",
    'TaskReminders': "Task Reminders",
    'Getnotified': "Get notified when tasks are due",
    'SoundEffects': "Sound Effects",
    'Playsounds': "Play sound notifications",
    'Regional': "Regional",
    'Selectlangage': "Select your preferred language",
    'Timezone': "Timezone",
    'Settimezone': "Set your local timezone",

    'Taskpage': "Task Page",
    'AddTask': "Add Task",
    'Tasktitle': "Task Title",
    'EnterTasktitle': "Enter Task Title",
    'description': "Description",
    'EnterTaskdescription': "Enter Task Description",
    'duedate': "Due Date",
    'selecteddate': "dd-MM-yyyy",
    'priority': "Priority",
    'selectpriority': "Select priority",
    'assignee': "Assignee",
    'enterassignee': "Enter Assignee name",
    'time': "Time",
    'selecttime': "Select Time",
  };

  String getText(String key) => texts[key] ?? '';

  void updateTexts(Map<String, String> updatedTexts) {
    texts.addAll(updatedTexts);
    notifyListeners();
  }
}class GlobalData {
  static const List<String> timezones = [
    'UTC-12:00',
    'UTC-11:00',
    'UTC+00:00',
    'UTC+01:00',
    'UTC+02:00',
  ];
}
class GlobalLanguage {
  static const List<String> language = [
    'English',
    'Hindi',
    'Spanish',
  ];
}



class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.blue,
      secondary: Colors.blueAccent,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.black87,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.black45,
      foregroundColor: Colors.white,
    ),
    colorScheme: ColorScheme.dark(
      primary: Colors.blue,
      secondary: Colors.blueAccent,
    ),
  );
}


/*
FFB100
FBC252
F0ECCF
A3BB98
*/
