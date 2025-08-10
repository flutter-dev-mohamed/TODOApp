import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/dataBase/task_class_mod.dart';

class CustomCheckbox extends StatefulWidget {
  CustomCheckbox({
    super.key,
    required this.task,
    required this.onChange,
  });
  final Function(Task) onChange;
  Task task;

  @override
  State<CustomCheckbox> createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

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
    super.dispose();
    _animationController.dispose();
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
        widget.onChange(widget.task);
      },
      child: Lottie.asset(
        'assets/Success.json',
        controller: _animationController,
      ),
    );
  }
}
