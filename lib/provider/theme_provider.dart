import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  // set theme mode
  void setThemeMode(ThemeMode mode) {
    themeMode = mode;
    notifyListeners();
  }

  ThemeData _themeData = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
  );

  ThemeData get themeData => _themeData;

  void updateTheme(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }
}
