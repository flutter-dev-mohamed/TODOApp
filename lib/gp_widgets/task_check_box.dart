import 'package:flutter/material.dart';
import 'package:TODOApp/dataBase/task_class_mod.dart';

class TaskCheckBox extends StatefulWidget {
  TaskCheckBox({super.key, required this.task, required this.onChange});
  final Function(Task) onChange;
  Task task;

  @override
  State<TaskCheckBox> createState() => _TaskCheckBoxState();
}

class _TaskCheckBoxState extends State<TaskCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: widget.task.isDone,
      onChanged: (bool? newValue) {
        setState(() {
          widget.task.isDone = !widget.task.isDone;
          widget.onChange(widget.task);
        });
      },
      shape: const CircleBorder(),
    );
  }
}
