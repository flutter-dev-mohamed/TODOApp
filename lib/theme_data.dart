import 'package:flutter/material.dart';

//   TODO: finish the theme!
//   TODO: Enable the user to select the app theme!

ThemeData themeData() {
  const String myFont = 'ArchitectsDaughter';

  ThemeData themeData = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0F9D8A),
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        fontFamily: myFont,
        color: Colors.black,
      ),
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0x0F9D8AFF)),
    fontFamily: myFont,
    useMaterial3: true,
  );

  return themeData;
}

// theme: ,
