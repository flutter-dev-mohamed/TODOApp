import 'package:flutter/material.dart';
import 'package:TODOApp/dataBase/task_class_mod.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key, required this.task, required this.taskCheckBox});
  final Task task;
  final Widget taskCheckBox;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task.title),
        actions: [
          taskCheckBox,
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20, // up & down
            ),
            child: Center(
              child: Text(
                task.lastEdit,
              ),
            ),
          ),
          Text(
            task.description,
            style: const TextStyle(
              fontSize: 18,
            ),
            textAlign: TextAlign.start,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {}, // TODO: Add the popup widget for options
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          size: 50,
        ),
      ),
    );
  }
}

class EditableTextWidget extends StatefulWidget {
  const EditableTextWidget({super.key});

  @override
  State<EditableTextWidget> createState() => _EditableTextWidgetState();
}

class _EditableTextWidgetState extends State<EditableTextWidget> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
