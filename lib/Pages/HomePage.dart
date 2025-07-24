import 'package:flutter/material.dart';
import 'package:test_again/dataBase/dataBase.dart';
import 'package:test_again/theamData.dart';
import 'package:test_again/Pages/taskCard.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TODO"),
      ),
      body: ListView.builder(
        //  TODO: Add the taskCard widget here!
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, index) {
          return Taskcard(task: tasks[index]);
        },
      ),
    );
  }
}
