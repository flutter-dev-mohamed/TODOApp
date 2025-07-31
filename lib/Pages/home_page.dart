import 'package:flutter/material.dart';
import 'package:todo_app/Pages/task_list_page.dart';
import 'package:todo_app/dataBase/database_helper.dart';
import 'package:todo_app/dataBase/task_group_class_mod.dart';
import 'package:todo_app/dataBase/task_class_mod.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseHelper dbHelper = DatabaseHelper();

  List<TaskGroup> taskGroupsList = [TaskGroup(title: 'title')];

  void loadTaskGroups() async {
    final loadedTaskGroups = await dbHelper.getTaskGroup();
    setState(() {
      taskGroupsList = loadedTaskGroups;
      print('TaskGroups Loaded!');
      print(taskGroupsList);
    });
  }

  void addTaskGroup(TaskGroup taskGroup) async {
    dbHelper.insertTaskGroup(taskGroup);
    print("new Task Group Added!");
    print(taskGroup);
  }

  void updateTaskGroup(TaskGroup taskGroup) async {
    dbHelper.updateTaskGroup(taskGroup);
    print("Task Group Updated!");
    print(taskGroup);
  }

  void deleteTaskGroup(TaskGroup taskGroup) async {
    dbHelper.deleteTaskGroup(taskGroup);
    print('Task Group Deleted!');
    print(taskGroup);
  }

  @override
  void initState() {
    print('\ninitState\n');
    super.initState();
    loadTaskGroups();
    print('\ninitState\n');
  }

  // callback function to show the done button
  bool isEditing = false;
  void edit(bool isEdit) {
    setState(() {
      isEditing = isEdit;
    });
  }

  List<Task> listOfTasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(taskGroupsList[0].title),
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
      body: TaskListPage(
          dbHelper: dbHelper,
          groupId: taskGroupsList[0].id!,
          edit: edit,
          listOfTasks: listOfTasks,
          pageTitle: 'ToDo'),
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
