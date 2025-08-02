import 'package:flutter/material.dart';
import 'package:todo_app/dataBase/data_class.dart';
import 'package:todo_app/dataBase/task_group_class_mod.dart';
import 'package:todo_app/gp_widgets/add_task_group_textfield.dart';
import 'package:todo_app/gp_widgets/task_group_button.dart';

class TaskgroupsDrawer extends StatefulWidget {
  TaskgroupsDrawer({
    super.key,
    required this.data,
    required this.getResultFromDrawer,
  });
  Data data;
  void Function({required int groupId, required int groupIndex})
      getResultFromDrawer;

  @override
  State<TaskgroupsDrawer> createState() => _TaskgroupsDrawerState();
}

class _TaskgroupsDrawerState extends State<TaskgroupsDrawer> {
  final ScrollController scrollController = ScrollController();

  void rebuild() async {
    await widget.data.loadTaskGroups();
    setState(() {});
  }

  void deleteTaskGroup({
    required TaskGroup taskGroup,
    required Function rebuild,
  }) {
    widget.data.deleteTaskGroup(taskGroup: taskGroup, rebuild: rebuild);
  }

  void updateTaskGroup({
    required TaskGroup taskGroup,
    required Function() rebuild,
  }) {
    widget.data.updateTaskGroup(taskGroup: taskGroup, rebuild: rebuild);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
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
                          : TaskGroupButton(
                              label: taskGroup.title,
                              getResultFromDrawer: widget.getResultFromDrawer,
                              groupIndex: index,
                              taskGroup: taskGroup,
                              delete: deleteTaskGroup,
                              updateTaskGroup: updateTaskGroup,
                              rebuild: rebuild,
                            );
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
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      widget.data.taskGroupsList
                          .add(TaskGroup(title: '', newTaskGroup: true));
                    });
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      scrollController.animateTo(
                        scrollController.position.maxScrollExtent,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    });
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Add a task group'),
                      Icon(Icons.format_list_bulleted_add),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
