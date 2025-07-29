import 'package:flutter/material.dart';
import 'package:TODOApp/dataBase/task_class_mod.dart';

class TaskPage extends StatefulWidget {
  const TaskPage(
      {super.key,
      required this.task,
      required this.taskCheckBox,
      required this.updateTask});

  final Task task;
  final Widget taskCheckBox;
  final Function(Task) updateTask;

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task.title),
        actions: [
          widget.taskCheckBox,
          IconButton(
              onPressed: () {
                setState(() {
                  isEditing = !isEditing;
                });
              },
              icon: isEditing
                  ? const Center(child: Text('Done'))
                  : const Icon(Icons.edit_rounded)),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            isEditing = !isEditing;
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20, // up & down
              ),
              child: Center(
                child: Text(
                  widget.task.lastEdit,
                  maxLines: 1,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: EditableTextWidget(
                initText: widget.task.description,
                updateTask: widget.updateTask,
                isEditing: isEditing,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {}, // TODO: Add the popup widget for options
        // shape: const CircleBorder(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: const Icon(
          Icons.edit_note_rounded,
          size: 50,
        ),
      ),
    );
  }
}

class EditableTextWidget extends StatefulWidget {
  EditableTextWidget(
      {super.key,
      required this.initText,
      required this.updateTask,
      this.isEditing = false});
  final String initText;
  bool isEditing;
  final Function(Task) updateTask;

  @override
  State<EditableTextWidget> createState() => _EditableTextWidgetState();
}

class _EditableTextWidgetState extends State<EditableTextWidget> {
  late String text;

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    text = widget.initText;
    _controller.text = text;
  }

  void _saveEdit() {
    setState(() {
      text = _controller.text;
      widget.isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('called me!');
    return widget.isEditing
        ? TextField(
            controller: _controller,
            autofocus: true,
            onSubmitted: (_) => _saveEdit(),
            onEditingComplete: _saveEdit,
            maxLines: null,
            minLines: 1,
            keyboardType: TextInputType.multiline,
          )
        : GestureDetector(
            onTap: () {
              setState(() {
                widget.isEditing = true;
              });
            },
            child: Text(
              text,
              style: const TextStyle(fontSize: 18),
              softWrap: false,
            ),
          );
  }
}
