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
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MyApp(themeProvider: themeProvider);
        },
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final ThemeProvider themeProvider;

  const MyApp({Key? key, required this.themeProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: themeProvider.currentTheme,
      home: const HomePage(),
    );
  }
}