import 'package:flutter/material.dart';
import 'package:todo_app/Pages/task_list_page.dart';
import 'package:todo_app/dataBase/data_class.dart';
import 'package:todo_app/dataBase/task_class_mod.dart';
import 'package:todo_app/Pages/taskGroups_drawer.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
    required this.data,
    required this.groupId,
    required this.groupIndex,
  });
  Data data;
  int groupId;
  int groupIndex;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //  autoscroll to textField
  final ScrollController scrollController = ScrollController();

  bool dataLoaded = false;
  Future<void> loadTasksData({required int groupId}) async {
    dataLoaded = false;
    await widget.data.loadTasks(groupId: groupId);
    setState(() {
      dataLoaded = true;
    });
  }

  @override
  void initState() {
    print('\n--------------------initState--------------------\n');
    super.initState();
    print('\nLoading Tasks Data...\n');
    loadTasksData(groupId: widget.groupId);
    print('\n--------------------initState--------------------\n');
  }

  // callback function to show the done button
  bool isEditing = false;
  void edit(bool isEdit) {
    setState(() {
      isEditing = isEdit;
    });
    // return isEditing;
  }

  void getResultFromDrawer(
      {required int groupId, required int groupIndex}) async {
    await loadTasksData(groupId: groupId);
    setState(() {
      widget.groupId = groupId;
      widget.groupIndex = groupIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!dataLoaded) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            title: Text(
              widget.data.taskGroupsList[widget.groupIndex].title,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            actions: isEditing
                ? [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          FocusScope.of(context).unfocus();
                          isEditing = false;
                        });
                      },
                      icon: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Done',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
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
          drawer: TaskgroupsDrawer(
            data: widget.data,
            getResultFromDrawer: getResultFromDrawer,
          ),
          body: TaskListPage(
            data: widget.data,
            groupId: widget.data.taskGroupsList[widget.groupIndex].id!,
            scrollController: scrollController,
            edit: edit,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              //  TODO: add the insert func
              setState(() {
                edit(true);
                widget.data.listOfTasks.add(Task(title: '', newTask: true));
              });
              WidgetsBinding.instance.addPostFrameCallback((_) {
                scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              });
            },
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: const Icon(
              Icons.add_circle_outline_rounded,
              size: 50,
            ),
          ),
        ),
      ],
    );
  }
}
