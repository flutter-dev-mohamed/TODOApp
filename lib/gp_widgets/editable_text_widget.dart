import 'package:flutter/material.dart';
import 'package:TribbianiNotes/dataBase/data_class.dart';
import 'package:TribbianiNotes/dataBase/task_class_mod.dart';

class EditableTextWidget extends StatefulWidget {
  EditableTextWidget({
    super.key,
    required this.task,
    required this.groupId,
    required this.edit,
    required this.rebuild,
    required this.focusNode,
    required this.controller,
    this.showHint = false,
    this.isTitle = false,
    this.textStyle = const TextStyle(),
  });
  Task task;
  bool showHint;
  bool isTitle;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextStyle textStyle;
  final int groupId;
  final Function() rebuild;
  final Function({required bool isEditing, required Task task, bool hint}) edit;

  @override
  State<EditableTextWidget> createState() => _EditableTextWidgetState();
}

class _EditableTextWidgetState extends State<EditableTextWidget> {
  final Data data = Data();
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();

    widget.focusNode.addListener(
      () {
        if (!widget.focusNode.hasFocus) _isEditing = false;
      },
    );

    if (widget.task.newTask) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          if (widget.isTitle) widget.focusNode.requestFocus();
          // we only request focus if the task is new and we want to show the Add Note hint
          widget.edit(isEditing: true, task: widget.task, hint: true);
        },
      );
    }
  }

  void onTap() {
    setState(() {
      _isEditing = true;
      widget.edit(isEditing: _isEditing, task: widget.task, hint: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    Color? defaultTextColor = Theme.of(context).textTheme.bodyMedium?.color;
    Color hinTextColor = (defaultTextColor ?? Colors.black).withAlpha(100);

    return _isEditing || widget.task.newTask
        ? textField(hinTextColor)
        : GestureDetector(
            onTap: onTap,
            child: showText(hinTextColor),
          );
  }

  Widget textField(Color hinTextColor) {
    return TextField(
      style: widget.textStyle,
      controller: widget.controller,
      focusNode: widget.focusNode,
      autofocus: !widget.task.newTask,
      maxLines: null,
      minLines: 1,
      textInputAction:
          widget.isTitle ? TextInputAction.done : TextInputAction.newline,
      keyboardType: TextInputType.multiline,
      onSubmitted: (value) => widget.focusNode.unfocus(),
      onEditingComplete: () => widget.focusNode.unfocus(),
      onTapUpOutside: (event) => widget.focusNode.unfocus(),

      //
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: widget.isTitle ? "New Reminder" : "Add note",
        hintStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: hinTextColor,
        ),
      ),
    );
  }

  Widget showText(Color hinTextColor) {
    return widget.isTitle
        ? Text(widget.task.title.isEmpty ? 'New Reminder' : widget.task.title,
            style: widget.textStyle)
        : widget.showHint && widget.task.description.isEmpty
            ? Text('Add Note', style: TextStyle(color: hinTextColor))
            : Text(widget.task.description);
  }
}
