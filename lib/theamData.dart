import 'package:flutter/material.dart';

//   TODO: finish the theam!

ThemeData themeData(bool DarckTheam) {
  const String MyFont = 'ArchitectsDaughter';

  ThemeData themeData = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFFCC93A),
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        fontFamily: MyFont,
        color: Colors.black,
      ),
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFCC93A)),
    fontFamily: MyFont,
    useMaterial3: true,
  );

  return themeData;
}

// theme: ,
