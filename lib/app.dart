//main app widget that manages theme state and provides it to the rest of the app

import 'package:flutter/material.dart';
import 'screens/calc_main_screen.dart';

class CalcApp extends StatefulWidget {
  const CalcApp({super.key});

  @override
  State<CalcApp> createState() => _CalcAppState();
}

class _CalcAppState extends State<CalcApp> {
  //track theme state, default to dark mode
  bool _isDark = true;

  //toggle theme mode and rebuild app
  void _toggleTheme() => setState(() => _isDark = !_isDark);

  @override
  Widget build(BuildContext context) {
    //define light theme using Material 3 color scheme
    final lightTheme = ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.grey.shade300,
      colorScheme: ColorScheme.light(
        primary: Colors.blue,
        onPrimary: Colors.black,
        surface: Colors.grey.shade200,
        onSurface: Colors.black,
      ),
      useMaterial3: true,
    );

    //define dark theme using Material 3 color scheme
    final darkTheme = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.blueGrey.shade900,
      colorScheme: ColorScheme.dark(
        primary: Colors.blue,
        onPrimary: Colors.white,
        surface: Colors.blueGrey.shade800,
        onSurface: Colors.white,
      ),
      useMaterial3: true,
    );

    //return MaterialApp with theme and home screen
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      home: CalcMainScreen(
        isDark: _isDark,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}