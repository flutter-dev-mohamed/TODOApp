import 'package:flutter/material.dart';
import 'package:TODOApp/dataBase/task_class_mod.dart';
import 'package:TODOApp/Pages/task_card.dart';
import 'package:TODOApp/dataBase/database_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.pageTitle});
  final String pageTitle;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseHelper dbHelper = DatabaseHelper();

  List<Task> listOfTasks = [
    Task(
      title: 'Buy groceries',
      description: 'Milk, Bread, Eggs',
    ),
    // Task(
    //   title: 'Study Flutter',
    //   description: 'Widgets, Themes, State Management',
    // ),
    // Task(title: 'Go for a walk'),
    // Task(
    //   title: 'Call Mom',
    //   description: 'Check in and say hello',
    // ),
    // Task(title: 'Clean the room'),
  ];

  void loadTasks() async {
    final loadTasks = await dbHelper.getTasks();
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
    dbHelper.insertTask(task);
    loadTasks();
  }

  void deleteTask(Task task) async {
    print('Task Deleted: ');
    print(task);
    dbHelper.deleteTask(task);
    loadTasks();
  }

  void updateTask(Task task) async {
    print('updateTask: taskId: ${task.id} isDone: ${task.isDone}');
    dbHelper.updateTask(task);
    loadTasks();
  }

  void onChange(Task task) {
    updateTask(task);
  }

  // callback function to show the done button
  void edit(bool isEdit) {
    setState(() {
      isEditing = isEdit;
    });
  }

  bool isEditing = false;
  final FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.pageTitle}'),
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
              focusNode: focusNode,
              task: listOfTasks[index],
              onChange: onChange,
              edit: edit,
              addTask: addTask,
              deleteTask: deleteTask,
              updateTask: updateTask,
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
