import 'package:flutter/material.dart';

class ThemeManager extends ChangeNotifier {
  ThemeManager._();
  static ThemeManager instance = ThemeManager._();
  factory ThemeManager() => instance;

  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  bool isDark() => themeMode == ThemeMode.dark;

  void toggleTheme(isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
