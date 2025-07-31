import 'package:todo_app/dataBase/task_class_mod.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class EditableTextWidget extends StatefulWidget {
  EditableTextWidget({
    super.key,
    this.textStyle = const TextStyle(),
    required this.initText,
    required this.task,
    required this.taskTitle,
    required this.updateTask,
    required this.addTask,
    required this.edit,
    required this.loadTasks,
    this.thisone = false,
  });
  bool thisone; //-------------------remove
  final String initText; //-------------------------------
  final TextStyle textStyle;
  Task task;
  bool taskTitle;
  final Function(Task) updateTask;
  final Function(Task) addTask;
  final Function() loadTasks;
  final Function(bool) edit;

  @override
  State<EditableTextWidget> createState() => _EditableTextWidgetState();
}

class _EditableTextWidgetState extends State<EditableTextWidget> {
  late String text; //-------------------------------
  bool isEditing = false; //-------------------------------
  bool newTask =
      false; // anewTask flag just for the FUCKING focusNode.dispose func!!!
  late TextEditingController _controller;
  FocusNode? _focusNode;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    if (widget.task.newTask) {
      _focusNode = FocusNode();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _focusNode!.requestFocus();
        newTask = true;
        widget.edit(true);
      });
    }
    text = widget.initText; //-------------------------------
    _controller.text = text; //-------------------------------
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    if (newTask) {
      _focusNode!.dispose();
    }
  }

  void _saveEdit() {
    text = _controller.text; //-------------------------------
    isEditing = false; //-------------------------------
    widget.edit(isEditing);
    if (widget.task.newTask) {
      if (_controller.text.isNotEmpty) {
        widget.task.title = _controller.text;
        widget.task.newTask = false;
        widget.addTask(widget.task);
      } else {
        widget.task.newTask = false;
        widget.edit(false);
      }
    } else {
      if (widget.taskTitle) {
        widget.task.title = text;
      } else {
        widget.task.description = text;
      }
      widget.updateTask(widget.task);
    }
    widget.loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    Color? defaultTextColor = Theme.of(context).textTheme.bodyMedium?.color;
    Color hinTextColor = (defaultTextColor ?? Colors.black).withOpacity(0.3);
    return (isEditing || widget.task.newTask)
        ? TextField(
            style: widget.textStyle,
            controller: _controller,
            focusNode: widget.task.newTask ? _focusNode : null,
            maxLines: null,
            minLines: 1,
            keyboardType: TextInputType.multiline,
            autofocus: true,
            onEditingComplete: _saveEdit,
            onTapOutside: (event) {
              setState(() {
                isEditing = false;
              });
              widget.edit(isEditing);
              _saveEdit();
            },

            //
            decoration: widget.taskTitle
                ? const InputDecoration(
                    border: InputBorder.none,
                  )
                : InputDecoration(
                    border: InputBorder.none,
                    hintText: "Add note",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: hinTextColor,
                    ),
                  ),
          )
        : GestureDetector(
            onTap: () {
              setState(() {
                isEditing = true;
                widget.edit(isEditing);
              });
            },
            child: Container(
              width: RenderErrorBox.minimumWidth,
              child: Text(
                text,
                style: widget.textStyle,
              ),
            ),
          );
  }
}
