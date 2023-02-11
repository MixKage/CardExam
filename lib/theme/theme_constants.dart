import 'package:flutter/material.dart';

const colorPrimary = Colors.deepOrangeAccent;
const colorAccent = Colors.orange;
const Color accentTextColorLight = Color.fromRGBO(82, 125, 170, 1.0);
const Color backgroundColorLight = Color.fromRGBO(226, 226, 226, 1.0);
const Color backgroundColorLightDown = Color.fromRGBO(216, 216, 216, 1.0);
const Color backgroundColorLightUp = Color.fromRGBO(236, 236, 236, 1.0);
const Color containerLight = Color.fromRGBO(246, 246, 246, 1.0);
const Color accentTextColorDark = Color.fromRGBO(82, 125, 170, 1.0);
const Color backgroundColorDark = Color.fromRGBO(18, 18, 18, 1.0);
const Color backgroundColorDarkDown = Color.fromRGBO(8, 8, 8, 1.0);
const Color backgroundColorDarkUp = Color.fromRGBO(28, 28, 28, 1.0);
const Color containerDark = Color.fromRGBO(38, 38, 38, 1.0);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: accentTextColorLight,
  backgroundColor: backgroundColorLight,
  appBarTheme: const AppBarTheme(
    backgroundColor: backgroundColorLightUp,
    centerTitle: true,
  ),
  scaffoldBackgroundColor: backgroundColorLight,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: accentTextColorLight,
    secondary: backgroundColorLightUp,
    onBackground: accentTextColorLight,
    onPrimary: Colors.black87,
    primaryContainer: containerLight,
  ),
  toggleableActiveColor: accentTextColorLight,
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      splashFactory: InkSparkle.splashFactory,
      foregroundColor: MaterialStateProperty.all<Color>(accentTextColorLight),
    ),
  ),
  textTheme: const TextTheme(
    bodySmall: TextStyle(
      color: Colors.black54,
      fontWeight: FontWeight.w400,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 3.0,
      splashFactory: InkSparkle.splashFactory,
      backgroundColor: backgroundColorLightUp,
      padding: const EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: Colors.black12,
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
    ),
    filled: true,
    fillColor: backgroundColorLightDown,
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  //primaryColor: accentTextColorDark,
  backgroundColor: backgroundColorDark,

  appBarTheme: const AppBarTheme(
    backgroundColor: backgroundColorDarkUp,
    centerTitle: true,
  ),

  scaffoldBackgroundColor: backgroundColorDark,
  colorScheme: ColorScheme.fromSwatch().copyWith(
    brightness: Brightness.dark,
    secondary: backgroundColorDarkUp,
    primary: accentTextColorDark,
    onBackground: accentTextColorLight,
    onPrimary: Colors.white70,
    primaryContainer: containerDark,
  ),

  iconTheme: const IconThemeData(
    color: Colors.white30,
  ),

  toggleableActiveColor: accentTextColorDark,
  textTheme: const TextTheme(
    bodySmall: TextStyle(
      color: Colors.white54,
      fontWeight: FontWeight.w400,
    ),
    titleLarge: TextStyle(color: Colors.white),
    displayLarge: TextStyle(color: Colors.white),
  ),

  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: const BorderSide(
        color: Colors.white30,
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
    ),
    filled: true,
    iconColor: Colors.white54,
    fillColor: backgroundColorDarkUp /*Colors.grey.withOpacity(0.1)*/,
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      splashFactory: InkSparkle.splashFactory,
      foregroundColor: MaterialStateProperty.all<Color>(accentTextColorDark),
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: accentTextColorDark,
      elevation: 3.0,
      backgroundColor: backgroundColorDarkUp,
      splashFactory: InkSparkle.splashFactory,
      padding: const EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
    ),
  ),
);
