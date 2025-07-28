import 'package:TODOApp/Pages/add_task_page.dart';
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
      // routes: {
      //   '/': (context) => const HomePage(pageTitle: "ToDo"),
      //   '/addTask': (context) => AddTaskPopup(addTask: /*addTask func*/, loadTasks: /*loadTasks func*/,),
      // },
      home: const HomePage(
        pageTitle: 'ToDo',
      ),
      theme: themeData(),
      debugShowCheckedModeBanner: false,
    );
  }
}
