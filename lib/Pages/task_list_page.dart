// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:todo_app/dataBase/task_class_mod.dart';
import 'package:todo_app/Pages/task_card.dart';
import 'package:todo_app/dataBase/data_class.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({
    super.key,
    required this.data,
    required this.groupId,
    // required this.pageTitle,
    required this.edit,
  });
  final Data data;
  final int groupId;
  // final String pageTitle;
  final Function(bool) edit;
  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  @override
  void initState() {
    super.initState();
    // loadTasks();
  }

  void onChange(Task task) {
    widget.data.updateTask(task: task, rebuild: rebuild);
  }

  void rebuild() async {
    await widget.data.loadTasks(groupId: widget.groupId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ListView.builder(
        //  TODO: Add the taskCard widget here!
        itemCount: widget.data.listOfTasks.length,
        itemBuilder: (BuildContext context, index) {
          return Taskcard(
            data: widget.data,
            task: widget.data.listOfTasks[index],
            groupId: widget.groupId,
            onChange: onChange,
            edit: widget.edit,
            rebuild: rebuild,
            // addTask: addTask,
            // deleteTask: deleteTask,
            // updateTask: updateTask,
          );
        },
      ),
    );
  }
}
