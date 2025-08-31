// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:TribbianiNotes/dataBase/task_class_mod.dart';
import 'package:TribbianiNotes/Pages/task_card.dart';
import 'package:TribbianiNotes/dataBase/data_class.dart';

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
      return emptyScreen();
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

  Widget emptyScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/empty_task_group.svg',
            height: MediaQuery.of(context).size.width * 0.4,
          ),
          const Divider(
            height: 20,
            color: Colors.transparent,
          ),
          Text(
            'No Tasks Yet!',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
