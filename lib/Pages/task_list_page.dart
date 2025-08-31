// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:todo_app/dataBase/task_class_mod.dart';
import 'package:todo_app/Pages/task_card.dart';
import 'package:todo_app/dataBase/data_class.dart';

class TaskListPage extends StatefulWidget {
  TaskListPage({
    super.key,
    required this.groupId,
    required this.edit,
    required this.scrollController,
  });
  final int groupId;
  final Function(bool, Task) edit;
  final ScrollController scrollController;

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  Data data = Data();

  @override
  void initState() {
    super.initState();
    // loadTasks();
  }

  void onChange(Task task) {
    data.updateTask(task: task, rebuild: rebuild);
  }

  void rebuild() async {
    await data.loadTasks(groupId: widget.groupId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (data.listOfTasks.isEmpty) {
      return Center(
        child: Text(
          'No tasks yet (^_^!)',
          style: TextStyle(
            color: Theme.of(context).colorScheme.tertiary,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 50, top: 4),
        controller: widget.scrollController,
        itemCount: data.listOfTasks.length,
        itemBuilder: (BuildContext context, index) {
          Task task = data.listOfTasks[index];
          return Taskcard(
            key: ValueKey(task.id),
            // data: widget.data,
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
