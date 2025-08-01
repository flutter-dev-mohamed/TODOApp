import 'package:flutter/material.dart';
import 'package:todo_app/dataBase/data_class.dart';
import 'package:todo_app/dataBase/task_group_class_mod.dart';
import 'package:todo_app/gp_widgets/add_task_group_textfield.dart';

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
  void rebuild() async {
    await widget.data.loadTaskGroups();
    setState(() {});
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
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.data.taskGroupsList.length,
                  itemBuilder: (context, index) {
                    return widget.data.taskGroupsList[index].newTaskGroup
                        ? AddTaskGroupTextfield(
                            data: widget.data,
                            taskGroup: widget.data.taskGroupsList[index],
                            rebuild: rebuild,
                          )
                        : TextButton(
                            onPressed: () {
                              try {
                                widget.getResultFromDrawer(
                                  groupId:
                                      widget.data.taskGroupsList[index].id!,
                                  groupIndex: index,
                                );
                                Navigator.pop(context);
                              } catch (e) {
                                print(
                                    '\n\n\nTaskGroupDrawer: TextButton Check widget.getResultFromDrawer\n\n\n');
                              }
                            },
                            child:
                                Text(widget.data.taskGroupsList[index].title),
                          );
                  },
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
