import 'package:flutter/material.dart';
import 'package:TODOApp/dataBase/task_class_mod.dart';

// TODO: Make this a popup

class AddTaskPage extends StatelessWidget {
  AddTaskPage({super.key, required this.addTask, required this.loadTasks});
  final Function() loadTasks;
  final Function(Task) addTask;
  Task task = Task(title: 'AddTaskPopUp!');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Center(child: Text('Cancel')),
          ),
        ),
        title: const Text('Add Task'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(11.0),
            child: GestureDetector(
              onTap: () {
                addTask(task);
                Navigator.pop(context);
                loadTasks();
              },
              child: const Text('Add'),
            ),
          ),
        ],
      ),
      body: Text('data'),
    );
  }
}
