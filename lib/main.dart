import 'package:flutter/material.dart';
import 'Pages/task_list_page.dart';
import 'theme_data.dart';
import 'package:todo_app/test.dart';
import 'package:todo_app/Pages/home_page.dart';

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
      home: HomePage(),
      theme: themeData(),
      debugShowCheckedModeBanner: false,
    );
  }
}
