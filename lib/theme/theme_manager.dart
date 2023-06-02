import 'package:cardexam/database/locale_data.dart';
import 'package:flutter/material.dart';

class ThemeManager extends ChangeNotifier {
  ThemeManager._();
  static ThemeManager instance = ThemeManager._();
  factory ThemeManager() => instance;

  ThemeMode _themeMode =
      LocaleData.instance.getDarkTheme() ? ThemeMode.dark : ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  bool isDark() => themeMode == ThemeMode.dark;

  Future<void> toggleTheme(isDark) async {
    await LocaleData.instance.putDarkTheme(value: isDark);
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
