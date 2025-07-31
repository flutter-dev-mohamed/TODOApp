import 'package:flutter/material.dart';
import 'package:todo_app/Pages/task_list_page.dart';
import 'package:todo_app/dataBase/database_helper.dart';
import 'package:todo_app/dataBase/task_group_class_mod.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseHelper dbHelper = DatabaseHelper();

  List<TaskGroup> taskGroupsList = [];

  void loadTaskGroups() async {
    final loadedTaskGroups = await dbHelper.getTaskGroup();
    setState(() {
      taskGroupsList = loadedTaskGroups;
      print('TaskGroups Loaded!');
    });
  }

  @override
  Widget build(BuildContext context) {
    return TaskListPage(dbHelper: dbHelper, pageTitle: 'ToDo');
  }
}
