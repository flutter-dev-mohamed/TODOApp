import 'package:flutter/material.dart';
import 'package:todo_app/dataBase/data_class.dart';
import 'package:todo_app/dataBase/task_class_mod.dart';

class EditableTextWidget extends StatefulWidget {
  EditableTextWidget({
    super.key,
    required this.task,
    required this.groupId,
    required this.edit,
    required this.rebuild,
    this.showHint = false,
    this.isTitle = false,
    this.textStyle = const TextStyle(),
  });
  Task task;
  bool showHint;
  bool isTitle;
  final TextStyle textStyle;
  final int groupId;
  final Function() rebuild;
  final Function({required bool isEditing, required Task task, bool hint}) edit;

  @override
  State<EditableTextWidget> createState() => _EditableTextWidgetState();
}

class _EditableTextWidgetState extends State<EditableTextWidget> {
  final Data data = Data();
  late TextEditingController _controller;
  late FocusNode _focusNode;
  late String initText;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();

    if (widget.task.newTask) {
      _focusNode = FocusNode();
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          _focusNode.requestFocus();
          // we only request focus if the task is new and we want to show the Add Note hint
          widget.edit(isEditing: true, task: widget.task, hint: true);
        },
      );
    }
    initText = widget.isTitle ? widget.task.title : widget.task.description;
    _controller.text = initText.trim();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    if (widget.task.newTask) _focusNode.dispose();
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

  void newTask({required String text}) {
    // handle title
    widget.isTitle ? widget.task.title = text : widget.task.description = text;

    data.addTask(
        task: widget.task, groupId: widget.groupId, rebuild: widget.rebuild);
  }

  void oldTask({required String text}) {
    // handle task title
    if (widget.isTitle) {
      if (text.isNotEmpty) widget.task.title = text;
      _controller.text = widget.task.title;
    } else {
      // handle task description
      widget.task.description = text;
    }
    data.updateTask(task: widget.task, rebuild: widget.rebuild);
  }

  void _saveEdit() {
    String text = _controller.text.trim();
    _isEditing = false;

    // new task
    if (widget.task.newTask) {
      widget.task.newTask = false;
      newTask(text: text);
    } else {
      // old task
      oldTask(text: text);
    }

    // lastly
    print(
        '-\n\n EditableTextWidget:\n _saveEdit:\n widget.task.title: "${widget.task.title}"\n\n');

    widget.edit(isEditing: _isEditing, task: widget.task);
    widget.rebuild();
  }

  void onEditingComplete() {
    _saveEdit();
  }

  void onSubmitted(String s) {
    _saveEdit();
  }

  void onTapOutside(PointerUpEvent event) {
    _saveEdit();
  }

  Widget textField(Color hinTextColor) {
    return TextField(
      style: widget.textStyle,
      controller: _controller,
      focusNode: widget.task.newTask && widget.isTitle ? _focusNode : null,
      autofocus: !widget.task.newTask,
      maxLines: null,
      minLines: 1,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.multiline,
      // onSubmitted: onSubmitted,
      onEditingComplete: onEditingComplete,
      onTapUpOutside: onTapOutside,

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
