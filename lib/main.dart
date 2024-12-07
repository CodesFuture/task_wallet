import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Addtask/task_provider.dart';
import 'Home/Home_page.dart';
import 'helper/code_text.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TextProvider()),
        ChangeNotifierProvider(create: (_) => ButtonStateProvider()),
        ChangeNotifierProvider(create: (_) => DatePickerProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      home: const HomePage(),
    );
  }
}