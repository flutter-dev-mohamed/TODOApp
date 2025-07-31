// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:todo_app/dataBase/task_class_mod.dart';
import 'package:todo_app/Pages/task_card.dart';
import 'package:todo_app/dataBase/database_helper.dart';

class TaskListPage extends StatefulWidget {
  TaskListPage({
    super.key,
    required this.dbHelper,
    required this.groupId,
    required this.pageTitle,
    required this.listOfTasks,
    required this.edit,
  });
  final DatabaseHelper dbHelper;
  final int groupId;
  final String pageTitle;
  List<Task> listOfTasks;
  final Function(bool) edit;
  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  void loadTasks() async {
    final loadTasks = await widget.dbHelper.getTasks(groupId: widget.groupId);
    setState(() {
      widget.listOfTasks = loadTasks;
      print('Tasks loaded!');
      print(loadTasks);
      print(widget.listOfTasks);
    });
  }

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  void addTask(Task task) async {
    print('Task Added:');
    print(task);
    widget.dbHelper.insertTask(task);
    loadTasks();
  }

  void deleteTask(Task task) async {
    print('Task Deleted: ');
    print(task);
    widget.dbHelper.deleteTask(task);
    loadTasks();
  }

  void updateTask(Task task) async {
    print(
        'updateTask: taskId: ${task.id} TaskGroupId: ${task.groupId} isDone: ${task.isDone}');
    widget.dbHelper.updateTask(task);
    loadTasks();
  }

  void onChange(Task task) {
    updateTask(task);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ListView.builder(
        //  TODO: Add the taskCard widget here!
        itemCount: widget.listOfTasks.length,
        itemBuilder: (BuildContext context, index) {
          return Taskcard(
            task: widget.listOfTasks[index],
            onChange: onChange,
            edit: widget.edit,
            addTask: addTask,
            deleteTask: deleteTask,
            updateTask: updateTask,
            loadTasks: loadTasks,
          );
        },
      ),
    );
  }
}
