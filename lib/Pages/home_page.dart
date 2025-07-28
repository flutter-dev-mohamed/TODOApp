import 'package:TODOApp/Pages/add_task_page.dart';
import 'package:flutter/material.dart';
import 'package:TODOApp/dataBase/task_class_mod.dart';
import 'package:TODOApp/Pages/task_card.dart';
import 'package:TODOApp/dataBase/database_helper.dart';
import 'package:TODOApp/dataBase/task_class_mod.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.pageTitle});
  final pageTitle;
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
    Task(
      title: 'Study Flutter',
      description: 'Widgets, Themes, State Management',
    ),
    Task(title: 'Go for a walk'),
    Task(
      title: 'Call Mom',
      description: 'Check in and say hello',
    ),
    Task(title: 'Clean the room'),
  ];

  void loadTasks() async {
    final loadTasks = await dbHelper.getTasks();
    setState(() {
      listOfTasks = loadTasks;
    });
  }

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  void addTask(Task task) async {
    dbHelper.insertTask(task);
    loadTasks();
  }

  void deleteTask(Task task) async {
    dbHelper.deleteTask(task);
    loadTasks();
  }

  void upDataTask(Task task) async {
    dbHelper.updateTask(task);
    loadTasks();
  }

  void onChange(Task task) {
    // TODO: implement this in db
    if (task.isDone) {
      upDataTask(task);
      setState(() {
        listOfTasks.remove(task);
        listOfTasks.add(task);
      });
    } else {
      setState(() {
        deleteTask(task);
        addTask(task);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.pageTitle}'),
      ),
      body: ListView.builder(
        //  TODO: Add the taskCard widget here!
        itemCount: listOfTasks.length,
        itemBuilder: (BuildContext context, index) {
          return Taskcard(
            task: listOfTasks[index],
            onChange: onChange,
            deleteTask: deleteTask,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //  TODO: add the insert func
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTaskPage(
                addTask: addTask,
                loadTasks: loadTasks,
              ),
            ),
          );
          // addTask(Task(title: "title"));
        },
        // shape: const CircleBorder(),
        // backgroundColor: Colors.transparent,
        elevation: 0,
        child: const Icon(
          Icons.add,
          size: 50,
        ),
      ),
    );
  }
}
