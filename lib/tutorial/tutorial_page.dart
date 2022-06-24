import 'package:cardexam/route/app_router.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../app.dart';

class TutorialPage extends StatelessWidget {
  const TutorialPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(),
      body: SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: 'Добро пожаловать!',
              body: 'Это первая страница!',
            ),
            PageViewModel(
              title: 'Используй!',
              body: 'Ведь это вторая страница!',
            ),
          ],
          onDone: () {
            App.appRouter.push(MyHomeRoute(title: "My Home Page"));
          },
          showBackButton: false,
          showSkipButton: true,
          showNextButton: false,
          skip: const Text("Skip"),
          done: const Text("Done"),
        ),
      ),
    );
  }
}
