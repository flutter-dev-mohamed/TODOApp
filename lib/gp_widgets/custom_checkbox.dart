import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/dataBase/task_class_mod.dart';
import 'package:todo_app/settings/settings.dart';

class CustomCheckbox extends StatefulWidget {
  CustomCheckbox({
    super.key,
    required this.task,
    required this.onChange,
    required this.deleteTask,
  });
  final Function(Task) onChange;
  final Function deleteTask;
  Task task;

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  Timer? _deleteTimer;

  void delete() {
    if (!Settings().autoDeleteDoneTask) return;

    cancel();

    _deleteTimer = Timer(
      const Duration(seconds: 3),
      () {
        cancel();
        widget.deleteTask();
      },
    );
  }

  void cancel() {
    _deleteTimer?.cancel();
    _deleteTimer = null;
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    if (widget.task.isDone) {
      _animationController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _deleteTimer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        widget.task.isDone = !widget.task.isDone;

        if (widget.task.isDone) {
          await _animationController.forward();
        } else {
          await _animationController.reverse();
        }
        widget.onChange(widget.task); // this is what rebuilds the parent widget
      },
      child: Lottie.asset(
        'assets/Success.json',
        controller: _animationController,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant CustomCheckbox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.task.isDone) {
      delete();
    } else {
      cancel();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.task.isDone) {
      delete();
    } else {
      cancel();
    }
  }
}
