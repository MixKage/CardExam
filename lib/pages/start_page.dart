import 'package:cardexam/database/locale_data.dart';
import 'package:cardexam/dio/internet_service.dart';
import 'package:cardexam/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class StartPage extends StatelessWidget {
  Future<void> startApp() async {
    if (LocaleData.instance
        .getInfoBool(Data.settingsApp, SettingsAppBool.isFirstStart)) {
      LocaleData.instance.initLocaleDb();
    }
    try {
      await InternetService.instance
          .executeRequest(InternetService.instance.loginUser());
    } on Exception {
      await NavigationService.instance.pushNamed(NavigationPaths.selectLogin);
    }
    await NavigationService.instance.pushNamed(NavigationPaths.homePage);
  }

  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    startApp();
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Shimmer.fromColors(
              baseColor: Colors.black87,
              highlightColor: Colors.white60,
              child: const Text(
                'Card\nExam',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 90,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
