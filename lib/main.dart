import 'package:cardexam/navigation/navigation_service.dart';
import 'package:cardexam/theme/theme_constants.dart';
import 'package:cardexam/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

// ThemeManager _themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();
  final NavigationService navigationService = NavigationService();

  @override
  void dispose() {
    //_themeManager.removeListener(themeListener);
    ThemeManager.instance.removeListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    navigationService.init(_navigatorKey);
    //_themeManager.addListener(themeListener);
    ThemeManager.instance.addListener(themeListener);
    super.initState();
  }

  void themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: ThemeManager.instance.isDark()
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        child: MaterialApp(
          navigatorKey: _navigatorKey,
          darkTheme: darkTheme,
          theme: lightTheme,
          themeMode: ThemeManager.instance.themeMode,
          initialRoute: navigationService.initialRoute,
          debugShowCheckedModeBanner: false,
          routes: navigationService.routes,
          onGenerateRoute: navigationService.onGenerateRoute,
        ),
      );
}
