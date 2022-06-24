// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    MyHomeRoute.name: (routeData) {
      final args = routeData.argsAs<MyHomeRouteArgs>();
      return CustomPage<dynamic>(
          routeData: routeData,
          child: MyHomePage(key: args.key, title: args.title),
          transitionsBuilder: pageTransition,
          durationInMilliseconds: 300,
          opaque: true,
          barrierDismissible: false);
    },
    TutorialRoute.name: (routeData) {
      return CustomPage<dynamic>(
          routeData: routeData,
          child: const TutorialPage(),
          transitionsBuilder: pageTransition,
          durationInMilliseconds: 300,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(MyHomeRoute.name, path: '/my-home-page'),
        RouteConfig(TutorialRoute.name, path: '/')
      ];
}

/// generated route for
/// [MyHomePage]
class MyHomeRoute extends PageRouteInfo<MyHomeRouteArgs> {
  MyHomeRoute({Key? key, required String title})
      : super(MyHomeRoute.name,
            path: '/my-home-page',
            args: MyHomeRouteArgs(key: key, title: title));

  static const String name = 'MyHomeRoute';
}

class MyHomeRouteArgs {
  const MyHomeRouteArgs({this.key, required this.title});

  final Key? key;

  final String title;

  @override
  String toString() {
    return 'MyHomeRouteArgs{key: $key, title: $title}';
  }
}

/// generated route for
/// [TutorialPage]
class TutorialRoute extends PageRouteInfo<void> {
  const TutorialRoute() : super(TutorialRoute.name, path: '/');

  static const String name = 'TutorialRoute';
}
