import 'package:TODOApp/dataBase/task_class_mod.dart';
import 'package:flutter/material.dart';

class NewTaskTitle extends StatefulWidget {
  NewTaskTitle({
    super.key,
    required this.edit,
    required this.task,
    required this.addTask,
    required this.textStyle,
  });
  final Function(Task) addTask;
  final Function(bool) edit;
  TextStyle textStyle;

  Task task;

  @override
  State<NewTaskTitle> createState() => _NewTaskTitleState();
}

class _NewTaskTitleState extends State<NewTaskTitle> {
  late TextEditingController controller;
  late FocusNode focusNode;
  String text = '';

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    controller = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      focusNode.requestFocus();
      widget.edit(true);
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    focusNode.dispose();
  }

  void _saveNewTask() {
    widget.task.title = controller.text;
    widget.task.newTask = false;
    widget.addTask(widget.task);
    print("NewTaskTilte: ");
    widget.edit(false);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              style: widget.textStyle,
              controller: controller,
              focusNode: focusNode,
              maxLines: null,
              minLines: 1,
              keyboardType: TextInputType.multiline,
              onTapOutside: (event) {
                widget.edit(false);
                _saveNewTask();
              },

              // onSubmitted: (_) => _saveNewTask(),
              onEditingComplete: _saveNewTask,

              //
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//

//

//

//

//

//

//

//

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
  });

  final String initText; //-------------------------------
  final TextStyle textStyle;
  Task task;
  bool taskTitle;
  final Function(Task) updateTask;
  final Function(Task) addTask;
  final Function(bool) edit;

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

    print(widget.task);
    widget.updateTask(widget.task);
  }

  @override
  Widget build(BuildContext context) {
    Color? defaultTextColor = Theme.of(context).textTheme.bodyMedium?.color;
    Color hinTextColor = (defaultTextColor ?? Colors.black).withOpacity(0.3);
    if (widget.task.newTask) {
      return NewTaskTitle(
        task: widget.task,
        edit: widget.edit,
        addTask: widget.addTask,
        textStyle: widget.textStyle,
      );
    } else {
      return isEditing
          ? TextField(
              style: widget.textStyle,
              controller: _controller,
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
              child: Text(
                text,
                style: widget.textStyle,
              ),
            );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
}
