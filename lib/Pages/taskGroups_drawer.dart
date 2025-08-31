import 'package:flutter/material.dart';
import 'package:TribbianiNotes/dataBase/data_class.dart';
import 'package:TribbianiNotes/dataBase/task_group_class_mod.dart';
import 'package:TribbianiNotes/gp_widgets/task_group_text_field.dart';
import 'package:TribbianiNotes/gp_widgets/task_group_button.dart';
import 'package:TribbianiNotes/gp_widgets/edit_task_group_button.dart';
import 'package:TribbianiNotes/settings/settings_button.dart';
import '../dataBase/task_class_mod.dart';

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
    if (!mounted) return;
    setState(() {});
  }

  Future<List<Task>> deleteTaskGroup({
    required TaskGroup taskGroup,
  }) async {
    List<Task> tasksToDelete;
    tasksToDelete = await widget.data.loadTasks(groupId: taskGroup.id!);

    for (Task task in tasksToDelete) {
      if (tasksToDelete.isNotEmpty) {
        widget.data.deleteTask(
          task: task,
          rebuild: () {},
        );
      }
    }

    widget.data.deleteTaskGroup(taskGroup: taskGroup, rebuild: rebuild);

    return tasksToDelete;
  }

  void undoDeleteTaskGroup(
      {required TaskGroup taskGroup, required List<Task> tasksToDelete}) async {
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
  }

  void updateTaskGroup({
    required TaskGroup taskGroup,
  }) {
    widget.data.updateTaskGroup(taskGroup: taskGroup, rebuild: rebuild);
  }

  void editing(bool editing, int index) {
    setState(() {
      widget.data.taskGroupsList[index].isEditing = editing;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
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
                          : widget.data.taskGroupsList[index].isEditing
                              ? EditTaskGroupButton(
                                  key: ValueKey(taskGroup.id),
                                  taskGroup: taskGroup,
                                  updateTaskGroup: updateTaskGroup,
                                  rebuild: rebuild)
                              : TaskGroupButton(
                                  key: ValueKey(taskGroup.id),
                                  label: taskGroup.title,
                                  getResultFromDrawer:
                                      widget.getResultFromDrawer,
                                  groupIndex: index,
                                  taskGroup: taskGroup,
                                  delete: deleteTaskGroup,
                                  updateTaskGroup: updateTaskGroup,
                                  undoDeleteTaskGroup: undoDeleteTaskGroup,
                                  rebuild: rebuild,
                                  editing: editing,
                                  index: index,
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
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 41,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(
                        flex: 1,
                        child: SettingsButton(),
                      ),
                      VerticalDivider(
                        color: Theme.of(context).colorScheme.onPrimary,
                        thickness: 1,
                        width: 1,
                      ),
                      Expanded(
                        flex: 3,
                        child: AddTaskGroupButton(),
                      ),
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

  //
  Widget AddTaskGroupButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(23),
            bottomRight: Radius.circular(23),
          ),
        ),
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
    );
  }
}
