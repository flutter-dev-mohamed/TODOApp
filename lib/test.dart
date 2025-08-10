import 'package:flutter/material.dart';
import 'package:todo_app/dataBase/data_class.dart';
import 'package:todo_app/dataBase/task_group_class_mod.dart';
import 'package:todo_app/gp_widgets/task_group_text_field.dart';
import 'package:todo_app/gp_widgets/task_group_button.dart';
import 'package:todo_app/gp_widgets/edit_task_group_button.dart';
import 'package:todo_app/settings/settings_button.dart';
import '../dataBase/task_class_mod.dart';

class Test extends StatefulWidget {
  Test({
    super.key,
    required this.data,
  });
  Data data;

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final ScrollController scrollController = ScrollController();

  void rebuild() async {
    await widget.data.loadTaskGroups();
    if (!mounted) return;
    setState(() {});
  }

  Future<List<Task>> deleteTaskGroup({
    required TaskGroup taskGroup,
  }) async {
    List<Task> tasksToDelete;
    tasksToDelete = await widget.data.loadTasks(groupId: taskGroup.id!);
    print(
        '\n\n-------------------------------group deleted-----------------****--------------------\n\n');

    for (Task task in tasksToDelete) {
      if (tasksToDelete.isNotEmpty) {
        widget.data.deleteTask(
          task: task,
          rebuild: () {},
        );
      }
    }

    widget.data.deleteTaskGroup(taskGroup: taskGroup, rebuild: rebuild);
    print(
        '\n\n-------------------------------group deleted-----------------****--------------------\n\n');

    return tasksToDelete;
  }

  void undoDeleteTaskGroup(
      {required TaskGroup taskGroup, required List<Task> tasksToDelete}) async {
    print(
        '\n\n-------------------------------Undeleted------------------@@@@@@-------------------\n\n');
    widget.data.addTaskGroup(taskGroup: taskGroup, rebuild: () {});

    for (Task task in tasksToDelete) {
      if (tasksToDelete.isNotEmpty) {
        widget.data.addTask(
          task: task,
          groupId: taskGroup.id!,
          rebuild: () {},
        );
      }
    }
    rebuild();

    print(
        '\n\n-------------------------------Undeleted------------------@@@@@@-------------------\n\n');
  }

  void updateTaskGroup({
    required TaskGroup taskGroup,
  }) {
    widget.data.updateTaskGroup(taskGroup: taskGroup, rebuild: rebuild);
  }

  void editing(bool editing, int index) {
    print('222222222222222222222222222222\n\n$editing\n$index\n\n');
    setState(() {
      widget.data.taskGroupsList[index].isEditing = editing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: 8.0,
                  right: 8.0,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 80.0),
                  child: ListView.builder(
                    controller: scrollController,
                    // shrinkWrap: true,
                    itemCount: widget.data.taskGroupsList.length,
                    itemBuilder: (context, index) {
                      TaskGroup taskGroup = widget.data.taskGroupsList[index];
                      return taskGroup.newTaskGroup
                          ? AddTaskGroupTextfield(
                              data: widget.data,
                              taskGroup: taskGroup,
                              rebuild: rebuild,
                            )
                          : EditTaskGroupButton(
                              key: ValueKey(taskGroup.id),
                              taskGroup: taskGroup,
                              updateTaskGroup: updateTaskGroup,
                              rebuild: rebuild);
                    },
                  ),
                ),
              ),
            ),

            //
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(
                      flex: 1,
                      child: SettingsButton(),
                    ),
                    Expanded(
                      flex: 3,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                        onPressed: () {
                          setState(() {
                            widget.data.taskGroupsList
                                .add(TaskGroup(title: '', newTaskGroup: true));
                          });
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            scrollController.animateTo(
                              scrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Add a task group',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                            Icon(
                              Icons.format_list_bulleted_add,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
