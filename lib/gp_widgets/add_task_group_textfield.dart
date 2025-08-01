import 'package:flutter/material.dart';
import 'package:todo_app/dataBase/data_class.dart';
import 'package:todo_app/dataBase/task_group_class_mod.dart';

class AddTaskGroupTextfield extends StatefulWidget {
  AddTaskGroupTextfield({
    super.key,
    required this.data,
    required this.taskGroup,
    required this.rebuild,
  });
  Data data;
  TaskGroup taskGroup;
  void Function() rebuild;

  @override
  State<AddTaskGroupTextfield> createState() => _AddTaskGroupTextfieldState();
}

class _AddTaskGroupTextfieldState extends State<AddTaskGroupTextfield> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _focusNode.dispose();
  }

  void _saveTaskGroup() {
    widget.taskGroup.title = _controller.text;
    widget.taskGroup.newTaskGroup = false;
    widget.data
        .addTaskGroup(taskGroup: widget.taskGroup, rebuild: widget.rebuild);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      maxLines: 1,
      onSubmitted: (_) => _saveTaskGroup(),
      autofocus: true,
      onTapOutside: (event) {
        widget.rebuild();
      },
    );
  }
}
