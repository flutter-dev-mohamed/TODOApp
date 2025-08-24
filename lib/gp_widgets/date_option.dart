import 'package:flutter/material.dart';
import 'package:todo_app/dataBase/task_class_mod.dart';
import 'package:todo_app/gp_widgets/date_or_time_picker.dart';
import 'package:todo_app/gp_widgets/timestamp.dart';

class DateOption extends StatefulWidget {
  DateOption({
    super.key,
    required this.task,
    required this.rebuild,
  });
  Task task;
  final void Function() rebuild;

  @override
  State<DateOption> createState() => _DateOptionState();
}

class _DateOptionState extends State<DateOption>
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
    animationController.value = widget.task.hasDate ? 1 : 0;
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  void didUpdateWidget(covariant DateOption oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.task.hasDate
        ? animationController.forward()
        : animationController.reverse();
  }

  void onTapToggleButton() {
    if (widget.task.hasDate) {
      animationController.reverse();
      widget.task.date = null;
    } else {
      animationController.forward();
      widget.task.date =
          '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}';
    }
    widget.rebuild();
  }

  void onDateTimeChanged(DateTime date) {
    widget.task.date =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

    widget.rebuild();
  }

  @override
  Widget build(BuildContext context) {
    return DateOrTimePicker(
      title: const Text('Date'),
      subtitle: widget.task.hasDate
          ? Timestamp(task: widget.task, dateOnly: true, fontSize: 12)
          : null,
      expand: expanded,

      animationController: animationController,
      onTapToggleButton: onTapToggleButton,
      onDateTimeChanged: onDateTimeChanged,
      onTap: widget.task.hasDate
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
          topRight: Radius.circular(16),
          topLeft: Radius.circular(16),
        ),
      ),
    );
  }
}
