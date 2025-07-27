import 'package:flutter/material.dart';
import 'package:TODOApp/dataBase/task_class_mod.dart';
import 'package:TODOApp/Pages/task_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void onChange(Task task) {
    if (task.isDone) {
      setState(() {
        listOfTasks.remove(task);
        listOfTasks.add(task);
      });
    } else {
      setState(() {
        listOfTasks.remove(task);
        listOfTasks.insert(0, task);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TODO"),
      ),
      body: ListView.builder(
        //  TODO: Add the taskCard widget here!
        itemCount: listOfTasks.length,
        itemBuilder: (BuildContext context, index) {
          return Taskcard(task: listOfTasks[index], onChange: onChange);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        // shape: Icon(Icons.add),
      ),
    );
  }
}
