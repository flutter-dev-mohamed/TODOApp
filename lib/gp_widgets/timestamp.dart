import 'package:flutter/material.dart';
import 'package:TribbianiNotes/dataBase/task_class_mod.dart';

class Timestamp extends StatefulWidget {
  Timestamp({
    super.key,
    required this.task,
    this.dateOnly = false,
    this.timeOnly = false,
    this.fontSize = 13,
  });
  Task task;
  final bool timeOnly;
  final bool dateOnly;
  final double? fontSize;

  @override
  State<Timestamp> createState() => _TimestampState();
}

class _TimestampState extends State<Timestamp> {
  String theDay() {
    DateTime now = DateTime.now();
    DateTime tomorrowDate = now.add(const Duration(days: 1));
    DateTime yesterdayDate = now.subtract(const Duration(days: 1));

    String toDay =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    String tomorrow =
        '${tomorrowDate.year}-${tomorrowDate.month.toString().padLeft(2, '0')}-${tomorrowDate.day.toString().padLeft(2, '0')}';
    String yesterday =
        '${yesterdayDate.year}-${yesterdayDate.month.toString().padLeft(2, '0')}-${yesterdayDate.day.toString().padLeft(2, '0')}';

    if (widget.task.date == toDay) return 'Today';

    if (widget.task.date == tomorrow) return 'Tomorrow';

    if (widget.task.date == yesterday) return 'Yesterday';

    return widget.task.date!;
  }

  String formatTime({bool includeDay = true}) {
    final timeParts = widget.task.time!.split(':');
    int hour = int.parse(timeParts[0]);
    final int minute = int.parse(timeParts[1]);

    String meridiem = 'AM';
    if (hour >= 12) {
      meridiem = 'PM';
      if (hour > 12) hour -= 12;
    }
    if (hour == 0) hour = 12;

    final mm = minute.toString().padLeft(2, '0');
    final t = '$hour:$mm $meridiem';

    return includeDay ? '${theDay()}, $t' : t;
  }

  bool isOverdue() {
    return DateTime.now()
        .isAfter(DateTime.parse('${widget.task.date} ${widget.task.time}'));
  }

  Color textColor(BuildContext context) {
    return isOverdue()
        ? Theme.of(context).colorScheme.error
        : Theme.of(context).colorScheme.primary;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.dateOnly) {
      return Text(
        theDay(),
        style: TextStyle(
          color: textColor(context),
          fontWeight: FontWeight.bold,
          fontSize: widget.fontSize,
        ),
      );
    }
    if (widget.timeOnly) {
      return Text(
        formatTime(includeDay: false),
        style: TextStyle(
          color: textColor(context),
          fontWeight: FontWeight.bold,
          fontSize: widget.fontSize,
        ),
      );
    }
    return Text(
      formatTime(),
      style: TextStyle(
        color: textColor(context),
        fontWeight: FontWeight.bold,
        fontSize: widget.fontSize,
      ),
    );
  }
}
