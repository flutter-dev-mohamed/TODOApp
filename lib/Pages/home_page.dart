import 'package:flutter/material.dart';
import 'package:todo_app/Pages/task_list_page.dart';
import 'package:todo_app/dataBase/data_class.dart';
import 'package:todo_app/dataBase/task_class_mod.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
    required this.data,
  });
  Data data;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void loadTasksData(int groupId) async {
    await widget.data.loadTasks(groupId: groupId);
  }

  @override
  void initState() {
    print('\n--------------------initState--------------------\n');
    super.initState();
    print('\nLoading Tasks Data...\n');
    loadTasksData(
        1); //--------------------------------------------------     ADD GROUP ID HEERREEEE!!!!!
    print('\n--------------------initState--------------------\n');
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
    if (widget.data.taskGroupsList.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data.taskGroupsList[0].title),
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
          data: widget.data,
          groupId: widget.data.taskGroupsList[0].id ?? 1,
          edit: edit,
          pageTitle: 'ToDo'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //  TODO: add the insert func
          setState(() {
            edit(true);
            widget.data.listOfTasks.add(Task(title: '', newTask: true));
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
