// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '../dataBase/task_class_mod.dart';
import 'task_page.dart';

const TextStyle titleTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18,
);
const TextStyle subTitleStyle = TextStyle(
  fontSize: 13,
);

Color? checkBoxColor;

class Taskcard extends StatelessWidget {
  Taskcard(
      {super.key,
      required this.task,
      required this.onChange,
      required this.deleteTask});
  final Function(Task) deleteTask;
  final Function(Task) onChange;
  Task task;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(task.id.toString()),
      child: ListTile(
        //  TODO: Add the onTap push -> TaskPage
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TaskPage(
                        task: task,
                        taskCheckBox:
                            TaskCheckBox(task: task, onChange: onChange),
                      )));
        },
        leading: TaskCheckBox(
          task: task,
          onChange: onChange,
        ),
        title: Text(
          task.title,
          style: titleTextStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          task.description,
          style: subTitleStyle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          deleteTask(task);
        }
      },
    );
  }
}

class TaskCheckBox extends StatefulWidget {
  TaskCheckBox({super.key, required this.task, required this.onChange});
  final Function(Task) onChange;
  Task task;

  @override
  State<TaskCheckBox> createState() => _TaskCheckBoxState();
}

class _TaskCheckBoxState extends State<TaskCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: widget.task.isDone,
      onChanged: (bool? newValue) {
        setState(() {
          widget.task.isDone = !widget.task.isDone;
          widget.onChange(widget.task);
        });
      },
      shape: const CircleBorder(),
    );
  }
}
