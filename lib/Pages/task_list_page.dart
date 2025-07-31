// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:todo_app/dataBase/task_class_mod.dart';
import 'package:todo_app/Pages/task_card.dart';
import 'package:todo_app/dataBase/database_helper.dart';

class TaskListPage extends StatefulWidget {
  const TaskListPage({
    super.key,
    required this.dbHelper,
    required this.pageTitle,
  });
  final DatabaseHelper dbHelper;
  final String pageTitle;
  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  List<Task> listOfTasks = [];

  void loadTasks() async {
    final loadTasks = await widget.dbHelper.getTasks();
    setState(() {
      listOfTasks = loadTasks;
      print('Tasks loaded!');
    });
  }

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  void addTask(Task task) async {
    print('Task Added:');
    print(task);
    widget.dbHelper.insertTask(task);
    loadTasks();
  }

  void deleteTask(Task task) async {
    print('Task Deleted: ');
    print(task);
    widget.dbHelper.deleteTask(task);
    loadTasks();
  }

  void updateTask(Task task) async {
    print(
        'updateTask: taskId: ${task.id} TaskGroupId: ${task.groupId} isDone: ${task.isDone}');
    widget.dbHelper.updateTask(task);
    loadTasks();
  }

  void onChange(Task task) {
    updateTask(task);
  }

  // callback function to show the done button
  bool isEditing = false;
  void edit(bool isEdit) {
    setState(() {
      isEditing = isEdit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pageTitle),
        actions: isEditing
            ? [
                IconButton(
                  onPressed: () {
                    setState(() {
                      FocusScope.of(context).unfocus();
                      isEditing = false;
                    });
                  },
                  icon: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Done',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                )
              ]
            : [],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: ListView.builder(
          //  TODO: Add the taskCard widget here!
          itemCount: listOfTasks.length,
          itemBuilder: (BuildContext context, index) {
            return Taskcard(
              task: listOfTasks[index],
              onChange: onChange,
              edit: edit,
              addTask: addTask,
              deleteTask: deleteTask,
              updateTask: updateTask,
              loadTasks: loadTasks,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //  TODO: add the insert func
          setState(() {
            edit(true);
            listOfTasks.add(Task(title: '', newTask: true));
          });
        },
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: const Icon(
          Icons.edit_note_rounded,
          size: 50,
        ),
      ),
    );
  }
}
