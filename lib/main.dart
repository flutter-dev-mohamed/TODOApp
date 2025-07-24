import 'package:flutter/material.dart';
import 'Pages/HomePage.dart';
import 'theamData.dart';
import 'package:test_again/dataBase/dataBase.dart';

void main() {
  runApp(const TestApp());
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homepage(),
      theme: themeData(false),
      debugShowCheckedModeBanner: false,
    );
  }
}
