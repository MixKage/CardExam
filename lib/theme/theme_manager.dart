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

  void toggleTheme(isDark) {
    LocaleData.instance
        .setInfo(Data.settingsApp, SettingsApp.darkMode, isDark.toString());
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
