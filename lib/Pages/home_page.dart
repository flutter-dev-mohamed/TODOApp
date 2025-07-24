import 'package:flutter/material.dart';
import 'package:test_again/dataBase/data_base.dart';
import 'package:test_again/Pages/task_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void onChange(MyTask task) {
    if (task.isChecked) {
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
    );
  }
}
