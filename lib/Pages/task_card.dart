// ignore_for_file: must_be_immutable
import 'package:TribbianiNotes/dataBase/data_class.dart';
import 'package:TribbianiNotes/gp_widgets/editable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:TribbianiNotes/gp_widgets/timestamp.dart';
import '../dataBase/task_class_mod.dart';
import 'package:TribbianiNotes/gp_widgets/task_check_box.dart';
import 'package:TribbianiNotes/gp_widgets/delete_task_button.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:TribbianiNotes/gp_widgets/custom_checkbox.dart';

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
    // required this.data,
    required this.groupId,
    required this.task,
    required this.edit,
    required this.onChange,
    required this.rebuild,
  });

  final Function() rebuild;
  final Function(Task) onChange;
  final Function(bool, Task) edit;
  // Data data;
  int groupId;
  Task task;

  @override
  State<Taskcard> createState() => _TaskcardState();
}

class _TaskcardState extends State<Taskcard> {
  Data data = Data();

  void deleteTask() async {
    data.deleteTask(task: widget.task, rebuild: widget.rebuild);
  }

  void undoDeleteTask() {
    data.addTask(
        task: widget.task, groupId: widget.groupId, rebuild: widget.rebuild);
  }

  bool showHint = false;

  void editCard({
    bool isEditing = false,
    required Task task,
    bool hint = false,
  }) {
    setState(() {
      showHint = hint;
    });
    widget.edit(isEditing, task);
  }

  // test
  late FocusNode _titleFocusNode;
  late FocusNode _descFocusNode;
  late TextEditingController _titleController;
  late TextEditingController _descController;
  @override
  void initState() {
    super.initState();
    _titleFocusNode = FocusNode();
    _descFocusNode = FocusNode();
    _titleFocusNode.addListener(handelFocus);
    _descFocusNode.addListener(handelFocus);

    _titleController = TextEditingController(text: widget.task.title);
    _descController = TextEditingController(text: widget.task.description);
  }

  @override
  void dispose() {
    super.dispose();
    _titleFocusNode.dispose();
    _titleController.dispose();
    _descFocusNode.dispose();
    _descController.dispose();
  }

  void handelFocus() {
    // if neither has focus
    if (!_titleFocusNode.hasFocus && !_descFocusNode.hasFocus) _commitTask();

    // if any of the two text fields has focus
    if (_titleFocusNode.hasFocus || _descFocusNode.hasFocus) {
      editCard(isEditing: true, task: widget.task, hint: true);
    }
  }

  void _commitTask() {
    String title = _titleController.text.trim();
    String desc = _descController.text.trim();

    if (title.isEmpty && desc.isEmpty) {
      editCard(task: widget.task);
      widget.rebuild();
      return;
    }

    widget.task.title = title.isNotEmpty ? title : "New Reminder";
    widget.task.description = desc;

    widget.task.newTask
        ? data.addTask(
            task: widget.task, groupId: widget.groupId, rebuild: widget.rebuild)
        : data.updateTask(task: widget.task, rebuild: widget.rebuild);
    editCard(task: widget.task);
    widget.rebuild();
  }

  //

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
                focusNode: _titleFocusNode,
                controller: _titleController,
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
                      focusNode: _descFocusNode,
                      controller: _descController,
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
