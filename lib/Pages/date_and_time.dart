import 'package:flutter/material.dart';
import 'package:todo_app/dataBase/task_class_mod.dart';
import 'package:todo_app/gp_widgets/date_option.dart';
import 'package:todo_app/gp_widgets/date_or_time_picker.dart';
import 'package:todo_app/gp_widgets/time_option.dart';

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
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Flex(
        direction: Axis.vertical,
        children: [
          AppBar(
            title: Text(
              'Date & Time',
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            centerTitle: true,
            leading: cancelButton(),
            leadingWidth: 75,
            actions: [applyButton()],

            //
            backgroundColor: Colors.transparent,
          ),
          Expanded(
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
              ],
            ),
          ))
        ],
      ),
    );
  }

  Widget cancelButton() {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text(
        'Cancel',
        maxLines: 1,
      ),
    );
  }

  Widget applyButton() {
    // TODO: Apply Changes
    return TextButton(
      onPressed: () {
        widget.updateTask();
        Navigator.pop(context);
      },
      child: const Text('Apply'),
    );
  }
}
