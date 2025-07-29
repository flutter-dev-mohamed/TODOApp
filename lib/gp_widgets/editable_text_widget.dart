import 'package:TODOApp/dataBase/task_class_mod.dart';
import 'package:flutter/material.dart';

class EditableTextWidget extends StatefulWidget {
  EditableTextWidget({
    super.key,
    this.textStyle = const TextStyle(),
    required this.initText,
    required this.task,
    required this.taskTitle,
    required this.updateTask,
    required this.edit,
    required this.newTask,
    required this.addTask,
    required this.focusNode,
  });

  final String initText; //-------------------------------
  final TextStyle textStyle;
  Task task;
  bool taskTitle;
  final Function(Task) updateTask;
  final Function(bool) edit;
  final Function(Task) addTask;
  bool newTask;
  final FocusNode focusNode;

  @override
  State<EditableTextWidget> createState() => _EditableTextWidgetState();
}

class _EditableTextWidgetState extends State<EditableTextWidget> {
  late String text; //-------------------------------
  bool isEditing = false; //-------------------------------

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    text = widget.initText; //-------------------------------
    _controller.text = text; //-------------------------------
    // Wait until after the widget is rendered before requesting focus
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.focusNode.requestFocus();
    });
  }

  void _saveEdit() {
    text = _controller.text; //-------------------------------
    isEditing = false; //-------------------------------
    widget.edit(isEditing);
    if (widget.taskTitle) {
      widget.task.title = text;
    } else {
      widget.task.description = text;
    }
    if (widget.newTask) {
      if (text.isNotEmpty) {
        print('new task added');
        print(widget.task);
        widget.addTask(widget.task);
      }
    } else {
      print(widget.task);
      widget.updateTask(widget.task);
    }
  }

  @override
  Widget build(BuildContext context) {
    Color? defaultTextColor = Theme.of(context).textTheme.bodyMedium?.color;
    Color hinTextColor = (defaultTextColor ?? Colors.black).withOpacity(0.3);

    return isEditing
        ? TextField(
            style: widget.textStyle,
            controller: _controller,
            focusNode: widget.focusNode,
            maxLines: null,
            minLines: 1,
            keyboardType: TextInputType.multiline,
            autofocus: true,
            onSubmitted: (_) => _saveEdit(),
            onEditingComplete: _saveEdit,
            onTapOutside: (event) {
              isEditing = false;
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
            child: Text(
              text,
              style: widget.textStyle,
            ),
          );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
}
