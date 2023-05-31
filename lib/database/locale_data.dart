import 'package:cardexam/database/card.dart';
import 'package:cardexam/database/questionanswer.dart';
import 'package:cardexam/theme/theme_manager.dart';
import 'package:cardexam/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

enum Data { settingsApp, card }

enum SettingsApp { darkMode, isFirstStart, versionApp }

enum SettingsAppBool { darkMode, isFirstStart }

extension BoolParsing on String? {
  bool parseBool() => this?.toLowerCase() == 'true';
}

class LocaleData {
  LocaleData._();
  bool isGuest = false;
  static LocaleData instance = LocaleData._();

  factory LocaleData() => instance;

  Future<String?> getInfo(Data data, Enum info) async {
    final box = await Hive.openBox(data.name);
    final String? ans = await box.get(info.name);
    debugPrint('Get: ${data.name} : ${info.name} : $ans');
    return ans;
  }

  Future<bool> getInfoBool(Data data, Enum info) async {
    final box = await Hive.openBox(data.name);
    final String? ans = box.get(info.name);
    debugPrint('Get bool: ${data.name} : ${info.name} : $ans');
    if (ans == null) {
      return false;
    }
    return ans.parseBool();
  }

  Future<void> setInfo(Data data, Enum info, String textInfo) async {
    final box = await Hive.openBox(data.name);
    await box.put(info.name, textInfo);
    debugPrint('Set: ${data.name} : ${info.name} : $textInfo');
  }

  Future<void> activateDb() async {
    final box = await Hive.openBox(Data.card.name);
    //
    Hive
      ..registerAdapter(QuestionAnswerAdapter())
      ..registerAdapter(CardAdapter());
  }

  Future<void> initLocaleDb() async {
    final box = await Hive.openBox(Data.settingsApp.name);
    if (!await getInfoBool(Data.settingsApp, SettingsApp.isFirstStart)) {
      await box.put(
        SettingsApp.darkMode.name,
        'true',
      );
      await box.put(
        SettingsApp.versionApp.name,
        versionApp.toString(),
      );
      await box.put(
        SettingsApp.isFirstStart.name,
        'true',
      );
      ThemeManager.instance.toggleTheme(true);
      debugPrint('Init locale Db');
    }
  }

  bool getDarkTheme() =>
      Hive.box(Data.settingsApp.name).get(SettingsApp.darkMode.name) == 'true';

  Future<void> deleteAll() async {
    final box = await Hive.openBox(Data.settingsApp.name);
    await box.deleteFromDisk();
  }
}
