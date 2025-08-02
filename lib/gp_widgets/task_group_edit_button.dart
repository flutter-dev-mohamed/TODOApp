import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:todo_app/dataBase/data_class.dart';
import 'package:todo_app/dataBase/task_group_class_mod.dart';

class TaskGroupEditButton extends StatefulWidget {
  TaskGroupEditButton({
    super.key,
    required this.taskGroup,
    required this.updateTaskGroup,
  });
  TaskGroup taskGroup;
  final Function({
    required TaskGroup taskGroup,
    required Function() rebuild,
  }) updateTaskGroup;
  @override
  State<TaskGroupEditButton> createState() => _TaskGroupEditButtonState();
}

class _TaskGroupEditButtonState extends State<TaskGroupEditButton> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
    );
  }
}
