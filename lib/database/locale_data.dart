import 'package:cardexam/utilities/constants.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

enum Data {
  settingsApp,
}

enum SettingsApp { darkMode, isFirstStart, versionApp }

enum SettingsAppBool { darkMode, isFirstStart }

extension BoolParsing on String? {
  bool parseBool() => this?.toLowerCase() == 'true';
}

class LocaleData {
  LocaleData._();

  static LocaleData instance = LocaleData._();

  factory LocaleData() => instance;

  String? getInfo(Data data, Enum info) {
    final box = Hive.box(data.name);
    final String? ans = box.get(data.name);
    debugPrint('${data.name} : ${info.name} : $ans');
    return ans;
  }

  bool getInfoBool(Data data, Enum info) {
    final String? ans = Hive.box(data.name).get(info.name);
    debugPrint('${data.name} : ${info.name} : $ans');
    if (ans == null) {
      return false;
    }
    return ans.parseBool();
  }

  void setInfo(Data data, Enum info, String textInfo) {
    Hive.box(data.name).put(info.name, textInfo);
    debugPrint('${data.name} : ${info.name} : $textInfo');
  }

  Future<void> initLocaleDb() async {
    await Hive.initFlutter();
    await Hive.openBox(Data.settingsApp.name);
    if (getInfoBool(Data.settingsApp, SettingsApp.isFirstStart)) {
      Hive.box(Data.settingsApp.name)
        ..put(SettingsApp.isFirstStart, true.toString())
        ..put(SettingsApp.versionApp, versionApp.toString())
        ..put(SettingsApp.darkMode, false.toString());
    }
  }

  bool getDarkTheme() =>
      getInfo(Data.settingsApp, SettingsApp.darkMode).parseBool();
}
