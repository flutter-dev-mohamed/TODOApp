import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:todo_app/dataBase/task_group_class_mod.dart';

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
  final Function({required TaskGroup taskGroup}) undoDeleteTaskGroup;
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
        blurBackgroundColor: const Color(0xFFD5E2DE),
        child: SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: () {
              try {
                getResultFromDrawer(
                  groupId: taskGroup.id!,
                  groupIndex: groupIndex,
                );
                Navigator.pop(context);
              } catch (e) {
                print(
                    '\n\n\nTaskGroupDrawer: TextButton Check widget.getResultFromDrawer\n\n\n');
              }
            },
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
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
    return FocusedMenuItem(
      backgroundColor: Colors.red[400],
      trailingIcon: const Icon(Icons.delete),
      title: const Text('Delete'),
      onPressed: () {
        delete(taskGroup: taskGroup);
        try {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${taskGroup.title} deleted'),
                TextButton(
                  onPressed: () {
                    undoDeleteTaskGroup(taskGroup: taskGroup);
                  },
                  child: const Row(
                    children: [
                      Text('Undo'),
                      // Icon(Icons.undo),
                    ],
                  ),
                ),
              ],
            ),
          ));
        } catch (e, s) {
          print(s);
        }
      },
    );
  }

  FocusedMenuItem edit(
      {required BuildContext context, required TaskGroup taskGroup}) {
    return FocusedMenuItem(
      backgroundColor: const Color(0xFFD5E2DE),
      trailingIcon: const Icon(Icons.edit_rounded),
      title: const Text('Edit'),
      onPressed: () {
        // AddTaskGroupTextfield(data: data, taskGroup: taskGroup, rebuild: rebuild);
        print('1111111111111111111111111');
        editing(true, index);
      },
    );
  }
}
