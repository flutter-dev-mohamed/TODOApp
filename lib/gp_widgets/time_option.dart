import 'package:flutter/material.dart';
import 'package:todo_app/dataBase/task_class_mod.dart';
import 'package:todo_app/gp_widgets/date_or_time_picker.dart';
import 'package:todo_app/gp_widgets/timestamp.dart';

class TimeOption extends StatefulWidget {
  TimeOption({
    super.key,
    required this.task,
    // required this.animationController,
    required this.rebuild,
  });
  Task task;
  final void Function() rebuild;
  // final AnimationController animationController;

  @override
  State<TimeOption> createState() => _TimeOptionState();
}

class _TimeOptionState extends State<TimeOption>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  bool expanded = false;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    if (widget.task.hasTime) animationController.value = 1.0;
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  void didUpdateWidget(covariant TimeOption oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.task.hasTime
        ? animationController.forward()
        : animationController.reverse();
  }

  String todayDate() {
    return '${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}';
  }

  void onTapToggleButton() {
    if (widget.task.hasTime) {
      animationController.reverse();
      widget.task.time = null;
    } else {
      widget.task.time =
          '${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}';
      animationController.forward();
    }

    widget.rebuild();
  }

  void onDateTimeChanged(DateTime date) {
    widget.task.time =
        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';

    widget.rebuild();
  }

  @override
  Widget build(BuildContext context) {
    return DateOrTimePicker(
      timePicker: true,
      title: const Text('Time'),
      subtitle: widget.task.hasTime
          ? Timestamp(task: widget.task, timeOnly: true, fontSize: 12)
          : null,
      expand: expanded,

      animationController: animationController,
      onTapToggleButton: onTapToggleButton,
      onDateTimeChanged: onDateTimeChanged,
      onTap: widget.task.hasTime
          ? () {
              setState(() {
                expanded = !expanded;
              });
            }
          : null,

      initialDate:
          DateTime.parse(widget.task.date ?? DateTime.now().toString()),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),

      //
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(16),
          bottomLeft: Radius.circular(16),
        ),
      ),
    );
  }
}
