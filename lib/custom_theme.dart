import 'package:flutter/material.dart';

class CustomTheme {
  ThemeData customTheme = ThemeData().copyWith(
    scaffoldBackgroundColor: Color(0xffE2E0E2),
    iconTheme: IconThemeData(color: Color(0xff403F40)),
    colorScheme: ThemeData().colorScheme.copyWith(tertiary: Color.fromARGB(255, 129, 128, 129)),
    textTheme: ThemeData().textTheme.copyWith(
          bodyMedium: TextStyle(fontSize: 16, color: Color.fromARGB(255, 129, 128, 129)),
        ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
    ),
  );
}
