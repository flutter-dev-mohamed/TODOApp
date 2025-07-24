import 'package:flutter/material.dart';
import '../dataBase/data_base.dart';

const TextStyle titleTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18,
);
const TextStyle subTitleStyle = TextStyle(
  fontSize: 13,
);

Color? checkBoxColor;

class Taskcard extends StatelessWidget {
  Taskcard({super.key, required this.task, required this.onChange});
  final Function(MyTask) onChange;
  MyTask task;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(task.id),
      child: ListTile(
        //  TODO: Add the onTap push -> TaskPage
        //  TODO: Add the checkBox ot leading!
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
    );
  }
}

class TaskCheckBox extends StatefulWidget {
  TaskCheckBox({super.key, required this.task, required this.onChange});
  final Function(MyTask) onChange;
  MyTask task;

  @override
  State<TaskCheckBox> createState() => _TaskCheckBoxState();
}

class _TaskCheckBoxState extends State<TaskCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: widget.task.isChecked,
      onChanged: (bool? newValue) {
        setState(() {
          widget.task.isChecked = !widget.task.isChecked;
          widget.onChange(widget.task);
        });
      },
      shape: const CircleBorder(),
    );
  }
}
