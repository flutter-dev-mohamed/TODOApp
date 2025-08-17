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
    required this.delete,
    required this.cancel,
  });
  final Function(Task) onChange;
  final Function deleteTask;
  final Function delete;
  final Function cancel;
  Task task;

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  // Timer? _deleteTimer;
  // int _deleteTime = 5;
  //
  // void delete() {
  //   print('-\n\n\n-\n\n');
  //   print('delete is called! ');
  //   cancel();
  //   print('-\n\n\n-\n\n');
  //
  //   _deleteTimer = Timer.periodic(
  //     const Duration(seconds: 1),
  //     (timer) {
  //       print('timer = $_deleteTime');
  //       _deleteTime--;
  //       if (_deleteTime <= 0) {
  //         cancel();
  //         widget.deleteTask();
  //       }
  //     },
  //   );
  // }
  //
  // void cancel() {
  //   print('canceled');
  //   _deleteTimer?.cancel();
  //   _deleteTimer = null;
  //   _deleteTime = 5;
  // }

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
    // _deleteTimer?.cancel();
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
          // widget.onChange(widget.task);

          widget.delete();
        } else {
          widget.cancel();
          await _animationController.reverse();
        }
        // widget.onChange(widget.task); // this is what rebuilds the parent widget
      },
      child: Lottie.asset(
        'assets/Success.json',
        controller: _animationController,
      ),
    );
  }

  // @override
  // void didUpdateWidget(covariant CustomCheckbox oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   print('widget updated!!\n\n\n');
  //   widget.task.deleteTimer.rebuild(widget.task.id!);
  // }
}
