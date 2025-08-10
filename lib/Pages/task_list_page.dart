// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:todo_app/dataBase/task_class_mod.dart';
import 'package:todo_app/Pages/task_card.dart';
import 'package:todo_app/dataBase/data_class.dart';

class TaskListPage extends StatefulWidget {
  TaskListPage({
    super.key,
    required this.data,
    required this.groupId,
    // required this.pageTitle,
    required this.edit,
    required this.scrollController,
  });
  final Data data;
  final int groupId;
  // final String pageTitle;
  final Function(bool) edit;
  final ScrollController scrollController;

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
      padding: const EdgeInsets.only(bottom: 10),
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 50, top: 4),
        controller: widget.scrollController,
        itemCount: widget.data.listOfTasks.length,
        itemBuilder: (BuildContext context, index) {
          Task task = widget.data.listOfTasks[index];
          return Taskcard(
            key: ValueKey(task.id),
            data: widget.data,
            task: task,
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
