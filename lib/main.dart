import 'package:flutter/material.dart';
import 'login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
          colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.deepOrange,
        brightness: Brightness.dark,
      )),
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}
