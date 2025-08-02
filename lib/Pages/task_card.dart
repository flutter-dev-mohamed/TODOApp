// ignore_for_file: must_be_immutable
import 'package:todo_app/dataBase/data_class.dart';
import 'package:todo_app/gp_widgets/editable_text_widget.dart';
import 'package:flutter/material.dart';
import '../dataBase/task_class_mod.dart';
import 'package:todo_app/gp_widgets/task_check_box.dart';
import 'package:todo_app/gp_widgets/delete_task_button.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

const TextStyle titleTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  // fontSize: 18,
);
const TextStyle subTitleStyle = TextStyle(
  fontSize: 13,
);

Color? checkBoxColor;

class Taskcard extends StatelessWidget {
  Taskcard({
    super.key,
    required this.data,
    required this.groupId,
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
  int groupId;
  Task task;

  void deleteTask() async {
    data.deleteTask(task: task, rebuild: rebuild);
  }

  @override
  Widget build(BuildContext context) {
    // print(task.title);
    // print(task.description);
    return SildableTaskCard(context);
  }

  Widget SildableTaskCard(context) {
    return Slidable(
      closeOnScroll: true,
      endActionPane: ActionPane(
        motion: DrawerMotion(),
        children: [
          DeleteTaskButton(
            key: key,
            delete: deleteTask,
          ),
        ],
      ),
      child: ClipRRect(
        child: ListTile(
          leading: TaskCheckBox(task: task, onChange: onChange),
          title: EditableTextWidget(
            rebuild: rebuild,
            data: data,
            groupId: groupId,
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
                      groupId: groupId,
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
      ),
    );
  }
}
