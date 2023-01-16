import 'package:cardexam/utilities/constants.dart';
import 'package:flutter/material.dart';

ThemeData basicTheme() => ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF527DAA),
        background: backgroundColor,
        brightness: Brightness.dark,
      ),
    ).copyWith(
      brightness: Brightness.dark,
      textTheme: const TextTheme(
        headline1: TextStyle(
          fontSize: 80.0,
          color: Color(0xFF282828),
          fontWeight: FontWeight.bold,
        ),
      ).apply(
        bodyColor: Colors.black,
        decorationColor: Colors.black,
        displayColor: Colors.black,
      ),
    );
