import 'package:flutter/material.dart';
import 'Pages/home_page.dart';
import 'theme_data.dart';

void main() {
  runApp(const TODOApp());
}

class TODOApp extends StatelessWidget {
  const TODOApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      theme: themeData(),
      debugShowCheckedModeBanner: false,
    );
  }
}
