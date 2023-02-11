import 'package:cardexam/database/locale_data.dart';
import 'package:cardexam/dio/internet_service.dart';
import 'package:cardexam/navigation/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:shimmer/shimmer.dart';

class StartPage extends StatelessWidget {
  Future<void> _goToNextPage(bool login) async {
    if (login) {
      await NavigationService.instance.pushNamed(NavigationPaths.homePage);
    } else {
      await NavigationService.instance.pushNamed(NavigationPaths.selectLogin);
    }
  }

  Future<bool> _startApp() async {
    if (await LocaleData.instance
            .getInfo(Data.settingsApp, SettingsApp.isFirstStart) ==
        'true') {
      await LocaleData.instance.initLocaleDb();
    }
    try {
      debugPrint('Start: Попытка входа в аккаунт');
      await InternetService.instance.executeRequest(
        () async => InternetService.instance.loginUser(),
      );
    } on Exception {
      debugPrint('Start: Не удалось войти в аккаунт');
      rethrow;
    }
    debugPrint('Start: Удалось войти в аккаунт');
    return true;
  }

  const StartPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: FutureBuilder(
              future: _startApp(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    if (snapshot.hasData.toString() == 'true') {
                      _goToNextPage(true);
                    } else {
                      // Недостижимый код
                      _goToNextPage(false);
                    }
                  });
                  return FittedBox(
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
                  );
                } else if (snapshot.hasError) {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    _goToNextPage(false);
                  });
                  return FittedBox(
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
                  );
                } else {
                  return FittedBox(
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
                  );
                }
              },
            ),
          ),
        ),
      );
}
