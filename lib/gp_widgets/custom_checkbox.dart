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

  void setTimer() {
    _deleteTimer?.cancel();
    _deleteTimer = null;

    if (settings.autoDeleteDoneTask) {
      if (widget.task.isDone) {
        print(
            '\n\n\n------------------Timer Started---------------------\n\n\n');
        _deleteTimer = Timer.periodic(
          const Duration(seconds: 5),
          (timer) {
            widget.deleteTask();
            timer.cancel();
          },
        );
      } else {
        print('\n\n------------Timer Canceled--------------------\n\n');
        _deleteTimer?.cancel();
      }
    }
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
          setTimer();
        } else {
          setTimer();
          await _animationController.reverse();
        }
        widget.onChange(widget.task);
      },
      child: Lottie.asset(
        'assets/Success.json',
        controller: _animationController,
      ),
    );
  }
}
