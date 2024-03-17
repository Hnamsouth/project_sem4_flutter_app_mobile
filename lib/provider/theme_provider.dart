import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  // set theme mode
  void setThemeMode(ThemeMode mode) {
    themeMode = mode;
    notifyListeners();
  }

  ThemeMode get getThemeMode => themeMode;
}
