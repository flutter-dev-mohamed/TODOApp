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
    if (widget.task.hasDate) {
      animationController.forward();
    } else {
      expanded = false;
      animationController.reverse();
    }
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

  late ColorScheme theme;
  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context).colorScheme;
    return DateOrTimePicker(
      title: const Text('Date'),
      subtitle: widget.task.hasDate
          ? Timestamp(task: widget.task, dateOnly: true, fontSize: 12)
          : null,
      leading: leadingIcon(),
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
        color: theme.secondaryContainer,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(16),
          topLeft: Radius.circular(16),
        ),
      ),
    );
  }

  Widget leadingIcon() {
    return SizedBox(
      width: 30,
      height: 30,
      child: Material(
        borderRadius: BorderRadius.circular(5.5),
        color: theme.surfaceContainer,
        elevation: 1,
        child: Icon(
          Icons.calendar_month_rounded,
          color: Colors.green[300],
        ),
      ),
    );
  }
}
