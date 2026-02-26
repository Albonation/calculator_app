import 'package:flutter/material.dart';
import '../screens/calc_main_screen.dart';

class CalcApp extends StatefulWidget {
  const CalcApp({super.key});

  @override
  State<CalcApp> createState() => _CalcAppState();
}

class _CalcAppState extends State<CalcApp> {
  bool _isDark = true;

  void _toggleTheme() => setState(() => _isDark = !_isDark);

  @override
  Widget build(BuildContext context) {
    final lightTheme = ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.grey.shade100,
      colorScheme: ColorScheme.light(
        primary: Colors.blue,
        onPrimary: Colors.white,
        surface: Colors.grey.shade200,
        onSurface: Colors.black,
      ),
      useMaterial3: true,
    );

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