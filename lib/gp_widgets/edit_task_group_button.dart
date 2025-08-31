import 'package:flutter/material.dart';
import 'package:TribbianiNotes/dataBase/task_group_class_mod.dart';

class EditTaskGroupButton extends StatefulWidget {
  EditTaskGroupButton({
    super.key,
    required this.taskGroup,
    required this.updateTaskGroup,
    required this.rebuild,
  });
  TaskGroup taskGroup;
  final Function() rebuild;
  final Function({
    required TaskGroup taskGroup,
  }) updateTaskGroup;
  @override
  State<EditTaskGroupButton> createState() => _EditTaskGroupButtonState();
}

class _EditTaskGroupButtonState extends State<EditTaskGroupButton> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  late String oldName;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _controller = TextEditingController();

    _controller.text = widget.taskGroup.title;
    oldName = widget.taskGroup.title;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _focusNode.dispose();
    _controller.dispose();
  }

  void _saveEdit() {
    if (_controller.text.isEmpty) {
      widget.rebuild();
    } else if (_controller.text.isNotEmpty) {
      widget.taskGroup.title = _controller.text;
      widget.updateTaskGroup(taskGroup: widget.taskGroup);
    }
    if (_controller.text != oldName) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 4,
                child: Text(
                  'Renamed to: ${widget.taskGroup.title}',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onTertiaryContainer,
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: TextButton(
                  onPressed: () {
                    widget.taskGroup.title = oldName;
                    widget.updateTaskGroup(
                      taskGroup: widget.taskGroup,
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        'Undo',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      // Icon(Icons.undo),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      key: widget.key,
      controller: _controller,
      focusNode: _focusNode,
      maxLines: 1,
      onSubmitted: (_) => _saveEdit(),
      onTapOutside: (event) {
        // FocusScope.of(context).unfocus();
        widget.rebuild();
      },

      //
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Theme.of(context).colorScheme.secondaryContainer,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.onSecondaryContainer,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
      ),
    );
  }
}
