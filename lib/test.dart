import 'package:flutter/material.dart';
import 'package:todo_app/dataBase/task_class_mod.dart';
import 'package:todo_app/dataBase/database_helper.dart';
import 'package:todo_app/dataBase/task_group_class_mod.dart';
import 'package:todo_app/Pages/task_list_page.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  DatabaseHelper dbHelper = DatabaseHelper();

  List<TaskGroup> taskGroupsList = [TaskGroup(title: 'title')];
  List<Task> listOfTasks = [];

  late Future<List<TaskGroup>> _futureTaskGroups;

  @override
  void initState() {
    super.initState();
    _futureTaskGroups = loadTaskGroups();
  }

  Future<List<TaskGroup>> loadTaskGroups() async {
    final loadedTaskGroups = await dbHelper.getTaskGroup();
    taskGroupsList = loadedTaskGroups; // No setState needed here
    print('TaskGroups Loaded!');
    print(taskGroupsList);
    return loadedTaskGroups;
  }

  void edit(bool isEdit) {
    setState(() {
      // isEditing = isEdit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TaskGroup>>(
      future: _futureTaskGroups, // use the cached future
      builder: (BuildContext context, AsyncSnapshot<List<TaskGroup>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No task groups found.'));
        }

        final groups = snapshot.data!;

        return TaskListPage(
          dbHelper: dbHelper,
          groupId: groups[0].id!,
          pageTitle: 'pageTitle',
          listOfTasks: listOfTasks,
          edit: edit,
        );
      },
    );
  }
}
