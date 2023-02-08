import 'package:cardexam/pages/home_page.dart';
import 'package:cardexam/pages/login_page.dart';
import 'package:cardexam/pages/signin_page.dart';
import 'package:cardexam/pages/signup_page.dart';
import 'package:cardexam/pages/test_page.dart';
import 'package:cardexam/pages/unknown_page.dart';
import 'package:flutter/material.dart';

enum NavigationPaths {
  start('/'),
  test('/test'),
  login('/login'),
  signUp('/sign_up'),
  homePage('/home_page'),
  unknown('/unknown');

  const NavigationPaths(this.path);
  final String path;
}

class NavigationService {
  NavigationService._();
  static NavigationService instance = NavigationService._();
  factory NavigationService() => instance;

  late final GlobalKey<NavigatorState> _globalKey;

  void init(GlobalKey<NavigatorState> key) {
    _globalKey = key;
  }

  final Map<String, WidgetBuilder> routes = {
    '/': (BuildContext context) => const LoginPage(),
    '/test': (BuildContext context) => const TestPage(),
    '/login': (BuildContext context) => const SecondLoginPage(),
    '/sign_up': (BuildContext context) => const SignUpPage(),
    '/home_page': (BuildContext context) => const HomePage(),
  };

  String get initialRoute => '/';

  Future<void> pushNamed(NavigationPaths pathEnum) async {
    await _globalKey.currentState?.push(
      PageRouteBuilder(
        settings: RouteSettings(name: pathEnum.path),
        pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) =>
            routes[pathEnum.path]?.call(context) ?? const UnknownPage(),
        transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
            FadeTransition(opacity: a, child: c),
      ),
    );
  }

  Route<dynamic>? onGenerateRoute(RouteSettings settings) => PageRouteBuilder(
        settings: settings,
        pageBuilder: (
          BuildContext context,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) =>
            routes[settings.name]?.call(context) ?? const SizedBox.shrink(),
        transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
            FadeTransition(opacity: a, child: c),
      );
}
