import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:todo_app/dataBase/task_group_class_mod.dart';

import '../dataBase/task_class_mod.dart';

class TaskGroupButton extends StatelessWidget {
  TaskGroupButton({
    super.key,
    required this.label,
    required this.getResultFromDrawer,
    required this.groupIndex,
    required this.taskGroup,
    required this.delete,
    required this.updateTaskGroup,
    required this.rebuild,
    required this.editing,
    required this.index,
    required this.undoDeleteTaskGroup,
  });

  void Function({required int groupId, required int groupIndex})
      getResultFromDrawer;
  final Function(
      {required TaskGroup taskGroup,
      required List<Task> tasksToDelete}) undoDeleteTaskGroup;
  final Function({required TaskGroup taskGroup}) delete;
  final Function({required TaskGroup taskGroup}) updateTaskGroup;
  final Function() rebuild;
  final Function(bool, int) editing;
  String label;
  TaskGroup taskGroup;
  int groupIndex;
  int index;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FocusedMenuHolder(
        menuWidth: 150.0,
        // menuOffset: ,
        onPressed: () {},
        menuItems: [
          edit(
            context: context,
            taskGroup: taskGroup,
          ),
          deleteButton(
            context: context,
            delete: delete,
            taskGroup: taskGroup,
          ),
        ],
        blurBackgroundColor: Theme.of(context).shadowColor,
        child: SizedBox(
          width: double.infinity,
          child: TextButton(
            style: TextButton.styleFrom(
              backgroundColor:
                  Theme.of(context).colorScheme.onSecondaryContainer,
            ),
            onPressed: () {
              try {
                getResultFromDrawer(
                  groupId: taskGroup.id!,
                  groupIndex: groupIndex,
                );
                Navigator.pop(context);
              } catch (e) {}
            },
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
            ),
          ),
        ),
      ),
    );
  }

  FocusedMenuItem deleteButton({
    required BuildContext context,
    required Function({
      required TaskGroup taskGroup,
    }) delete,
    required TaskGroup taskGroup,
    // required Function() rebuild,
  }) {
    List<Task> tasksToDelete;
    return FocusedMenuItem(
      backgroundColor: Theme.of(context).colorScheme.errorContainer,
      // backgroundColor: Colors.red[400],
      trailingIcon: Icon(
        Icons.delete,
        color: Theme.of(context).colorScheme.error,
      ),
      title: const Text('Delete'),
      onPressed: () async {
        tasksToDelete = await delete(taskGroup: taskGroup);
        try {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${taskGroup.title} deleted',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onTertiaryContainer,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      undoDeleteTaskGroup(
                          taskGroup: taskGroup, tasksToDelete: tasksToDelete);
                    },
                    child: Row(
                      children: [
                        Text(
                          'Undo',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        // Icon(Icons.undo),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        } catch (e, s) {}
      },
    );
  }

  FocusedMenuItem edit(
      {required BuildContext context, required TaskGroup taskGroup}) {
    return FocusedMenuItem(
      // backgroundColor: const Color(0xFFD5E2DE),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      trailingIcon: Icon(
        Icons.edit_rounded,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: const Text('Edit'),
      onPressed: () {
        // AddTaskGroupTextfield(data: data, taskGroup: taskGroup, rebuild: rebuild);
        editing(true, index);
      },
    );
  }
}
