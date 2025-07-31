// ignore_for_file: must_be_immutable
import 'package:todo_app/dataBase/data_class.dart';
import 'package:todo_app/gp_widgets/editable_text_widget.dart';
import 'package:flutter/material.dart';
import '../dataBase/task_class_mod.dart';
import 'package:todo_app/gp_widgets/task_check_box.dart';

const TextStyle titleTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18,
);
const TextStyle subTitleStyle = TextStyle(
  fontSize: 13,
);

Color? checkBoxColor;

class Taskcard extends StatelessWidget {
  Taskcard({
    super.key,
    required this.data,
    required this.task,
    required this.edit,
    required this.onChange,
    // required this.deleteTask,
    // required this.updateTask,
    // required this.addTask,
    required this.rebuild,
  });

  // final Function(Task) addTask;
  // final Function(Task) deleteTask;
  // final Function(Task) updateTask;
  final Function() rebuild;
  final Function(Task) onChange;
  final Function(bool) edit;
  Data data;
  Task task;

  @override
  Widget build(BuildContext context) {
    // print(task.title);
    // print(task.description);
    return Column(
      children: [
        Dismissible(
          key: Key(task.id.toString()),
          child: ListTile(
            leading: TaskCheckBox(task: task, onChange: onChange),
            title: EditableTextWidget(
              rebuild: rebuild,
              data: data,
              initText: task.title,
              taskTitle: true,
              task: task,
              edit: edit,
              // updateTask: updateTask,
              textStyle: titleTextStyle,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: task.newTask
                  ? []
                  : [
                      EditableTextWidget(
                        data: data,
                        rebuild: rebuild,
                        initText: task.description,
                        taskTitle: false,
                        task: task,
                        edit: edit,
                      ),
                      const Divider(
                        height: 1,
                      ),
                    ],
            ),
          ),
          onDismissed: (direction) {
            if (direction == DismissDirection.endToStart) {
              data.deleteTask(task);
            } else if (direction == DismissDirection.startToEnd) {}
          },
        ),
      ],
    );
  }
}
