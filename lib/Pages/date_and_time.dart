import 'package:flutter/material.dart';
import 'package:todo_app/dataBase/task_class_mod.dart';
import 'package:todo_app/gp_widgets/date_option.dart';
import 'package:todo_app/gp_widgets/date_or_time_picker.dart';
import 'package:todo_app/gp_widgets/repeat_button.dart';
import 'package:todo_app/gp_widgets/time_option.dart';
import 'package:todo_app/settings/settings.dart';

class DateAndTime extends StatefulWidget {
  DateAndTime({
    super.key,
    required this.taskToEditDate,
    required this.updateTask,
  });
  Task taskToEditDate;
  final Function() updateTask;
  @override
  State<DateAndTime> createState() => _DateAndTimeState();
}

class _DateAndTimeState extends State<DateAndTime> {
  void rebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Flex(
        direction: Axis.vertical,
        children: [
          AppBar(
            title: Text(
              'Date & Time',
              style: TextStyle(color: theme.primary),
            ),
            centerTitle: true,
            leading: cancelButton(),
            leadingWidth: 75,
            actions: [applyButton()],

            //
            backgroundColor: Colors.transparent,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    DateOption(
                      task: widget.taskToEditDate,
                      rebuild: rebuild,
                    ),
                    Divider(
                      height: 0,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    TimeOption(
                      task: widget.taskToEditDate,
                      // animationController: timePickerAC,
                      rebuild: rebuild,
                    ),
                    const Divider(color: Colors.transparent),
                    repeatButton(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget cancelButton() {
    return TextButton(
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
      child: const Text(
        'Cancel',
        maxLines: 1,
      ),
    );
  }

  Widget applyButton() {
    // TODO: Schedule an notification
    return TextButton(
      onPressed: () {
        if (widget.taskToEditDate.date == null &&
            widget.taskToEditDate.time == null) {
          Navigator.of(context, rootNavigator: true).pop();
          return;
        }
        try {
          widget.updateTask();
          Settings().scheduleNotification(task: widget.taskToEditDate);
          Navigator.of(context, rootNavigator: true).pop();
        } catch (e) {
          print('=\n\nDateAndTime:\napplyButton:\n$e\n\n');
        }
      },
      child: const Text('Apply'),
    );
  }

  Widget repeatButton() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      transitionBuilder: (child, animation) {
        final slideIn = Tween<Offset>(
          begin: const Offset(0, -1),
          end: Offset.zero,
        ).animate(animation);

        final slideOut = Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(animation);

        // print('-\nslideIn: $slideIn\n\n');
        // print('-\nslidOut: $slideOut\n\n');

        return SlideTransition(
          // position: child.key == const ValueKey('repeat') ? slideIn : slideOut,
          position: slideIn,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      child: (widget.taskToEditDate.date != null)
          ? RepeatButton(
              key: const ValueKey('repeat'),
              task: widget.taskToEditDate,
            )
          : const SizedBox(key: ValueKey('empty')),
    );
  }
}
