// ignore_for_file: must_be_immutable
import 'package:todo_app/dataBase/data_class.dart';
import 'package:todo_app/gp_widgets/editable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/gp_widgets/timestamp.dart';
import '../dataBase/task_class_mod.dart';
import 'package:todo_app/gp_widgets/task_check_box.dart';
import 'package:todo_app/gp_widgets/delete_task_button.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/gp_widgets/custom_checkbox.dart';

const TextStyle titleTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  // fontSize: 18,
);
const TextStyle subTitleStyle = TextStyle(
  fontSize: 13,
);

Color? checkBoxColor;

class Taskcard extends StatefulWidget {
  Taskcard({
    super.key,
    required this.data,
    required this.groupId,
    required this.task,
    required this.edit,
    required this.onChange,
    required this.rebuild,
  });

  final Function() rebuild;
  final Function(Task) onChange;
  final Function(bool, Task) edit;
  Data data;
  int groupId;
  Task task;

  @override
  State<Taskcard> createState() => _TaskcardState();
}

class _TaskcardState extends State<Taskcard> {
  void deleteTask() async {
    widget.data.deleteTask(task: widget.task, rebuild: widget.rebuild);
  }

  void undoDeleteTask() {
    widget.data.addTask(
        task: widget.task, groupId: widget.groupId, rebuild: widget.rebuild);
  }

  bool showHint = false;

  void editCard({
    required bool isEditing,
    required Task task,
    bool hint = false,
  }) {
    setState(() {
      showHint = hint;
    });
    widget.edit(isEditing, task);
  }

  @override
  Widget build(BuildContext context) {
    // print(task.title);
    // print(task.description);
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: Container(
          color: widget.task.isDone
              ? Theme.of(context).colorScheme.secondaryContainer
              : null,
          child: Slidable(
            closeOnScroll: true,
            endActionPane: ActionPane(
              motion: DrawerMotion(),
              children: [
                DeleteTaskButton(
                  key: widget.key,
                  delete: deleteTask,
                  undoDeleteTask: undoDeleteTask,
                ),
              ],
            ),
            child: ListTile(
              leading: CustomCheckbox(
                task: widget.task,
                onChange: widget.onChange,
                deleteTask: deleteTask,
              ),
              title: EditableTextWidget(
                rebuild: widget.rebuild,
                // data: data,
                groupId: widget.groupId,
                // initText: task.title,
                isTitle: true,
                task: widget.task,
                edit: editCard,
                // // updateTask: updateTask,
                textStyle: titleTextStyle,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.task.description.isNotEmpty || showHint)
                    EditableTextWidget(
                      // data: data,
                      groupId: widget.groupId,
                      rebuild: widget.rebuild,
                      // initText: task.description,
                      task: widget.task,
                      edit: editCard,
                      showHint: showHint,
                    ),
                  if (widget.task.hasDate || widget.task.hasTime)
                    Timestamp(
                      task: widget.task,
                      fontSize: 12,
                    ),
                  const Divider(
                    height: 1,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
