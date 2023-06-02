import 'package:cardexam/database/card.dart';
import 'package:cardexam/database/questionanswer.dart';
import 'package:cardexam/theme/theme_manager.dart';
import 'package:cardexam/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocaleData {
  LocaleData._();
  bool isGuest = false;
  static LocaleData instance = LocaleData._();

  factory LocaleData() => instance;

  late final Box _cardBox;
  late final Box _settingsBox;
  late final bool isFirstLaunch;

  int _dbVersion = 0;
  int get dbVersion => _dbVersion;

  Future<void> initAsync() async {
    Hive
      ..registerAdapter(QuestionAnswerAdapter())
      ..registerAdapter(CardAdapter());
    _cardBox = await Hive.openBox('card');
    _settingsBox = await Hive.openBox('settings');
    isFirstLaunch = _settingsBox.get(_isFirstLaunchKey, defaultValue: true);
    await _settingsBox.put(_isFirstLaunchKey, false);
    ThemeManager.instance.toggleTheme(getDarkTheme());
    await migrate();
    debugPrint('Init locale Db');
  }

  Future<void> migrate() async {
    _dbVersion = _settingsBox.get(_databaseVersion, defaultValue: 0);
    if (dbVersion < versionApp) {
      // тут твои миграции
    }
    await _settingsBox.put(_databaseVersion, versionApp);
  }

  static const String _darkModeKey = 'darkmode';
  static const String _isFirstLaunchKey = 'is_first_launch';
  static const String _databaseVersion = 'db_version';

  bool getDarkTheme() => _settingsBox.get(
        _darkModeKey,
        defaultValue: false,
      );

  Future<void> putDarkTheme({required bool value}) => _settingsBox.put(
        _darkModeKey,
        value,
      );

  Future<void> userDeleteAll() async {
    await _cardBox.deleteAll(
      [],
    );
    await _settingsBox.deleteAll(
      [
        _darkModeKey,
        _isFirstLaunchKey,
      ],
    );
    await migrate();
  }
}
