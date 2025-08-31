import 'package:flutter/material.dart';
import 'package:TribbianiNotes/Pages/date_and_time.dart';
import 'package:TribbianiNotes/Pages/task_list_page.dart';
import 'package:TribbianiNotes/dataBase/data_class.dart';
import 'package:TribbianiNotes/dataBase/task_class_mod.dart';
import 'package:TribbianiNotes/Pages/taskGroups_drawer.dart';
import 'package:TribbianiNotes/gp_widgets/custom_bottom_sheet.dart';
import 'package:TribbianiNotes/settings/notification.dart';
import 'package:TribbianiNotes/settings/settings.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
    required this.groupId,
    required this.groupIndex,
  });
  int groupId;
  int groupIndex;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Data data = Data();

  //  autoscroll to textField
  final ScrollController scrollController = ScrollController();

  bool dataLoaded = false;
  Future<void> loadTasksData({required int groupId}) async {
    dataLoaded = false;
    await data.loadTasks(groupId: groupId);
    setState(() {
      dataLoaded = true;
    });
  }

  void rebuildHomePage() {
    print('-\n\nHomePage:\nrebuild\n\n');
    // TODO: add the after first frame call
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        loadTasksData(groupId: widget.groupId);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    loadTasksData(groupId: widget.groupId);
  }

  // callback function to show the done button
  Task? taskToEditDate;
  bool isEditing = false;
  void edit(bool isEdit, Task task) {
    setState(() {
      isEditing = isEdit;
      taskToEditDate = task;
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

  // TODO: add an alert dialog to tell the user:
  //  you can cancel notification for individual task groups from the devices settings
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
              data.taskGroupsList[widget.groupIndex].title,
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
            data: data,
            getResultFromDrawer: getResultFromDrawer,
          ),
          body: TaskListPage(
            groupId: data.taskGroupsList[widget.groupIndex].id!,
            scrollController: scrollController,
            edit: edit,
          ),
          floatingActionButton: isEditing ? null : floatingActionButton(),
          bottomSheet: isEditing
              ? CustomBottomSheet(
                  data: data,
                  rebuildHomePage: rebuildHomePage,
                  task: taskToEditDate!,
                )
              : null,
        ),
      ],
    );
  }

  Widget floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        //  TODO: add the insert func
        setState(() {
          Task task = Task(
            title: '',
            newTask: true,
          );
          edit(true, task);
          print(task);
          data.listOfTasks.add(task);
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
      child: Icon(
        Icons.add_task_rounded,
        size: 50,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
