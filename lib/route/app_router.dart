import 'package:auto_route/auto_route.dart';
import 'package:cardexam/tutorial/tutorial_page.dart';
import 'package:flutter/material.dart';

import 'package:cardexam/app.dart';

part 'app_router.gr.dart';

@CustomAutoRouter(
  replaceInRouteName: 'Page,Route',
  transitionsBuilder: pageTransition,
  durationInMilliseconds: 300,
  routes: <AutoRoute>[
    AutoRoute(page: MyHomePage),
    AutoRoute(page: TutorialPage, initial: true)
  ],
)
class AppRouter extends _$AppRouter {
  AppRouter() : super();
}

Widget pageTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) =>
    FadeTransition(
      opacity: animation,
      child: child,
    );
