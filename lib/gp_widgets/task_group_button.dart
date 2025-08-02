import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:todo_app/dataBase/task_group_class_mod.dart';
import 'package:todo_app/gp_widgets/task_group_edit_button.dart';

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
  });
  String label;
  void Function({required int groupId, required int groupIndex})
      getResultFromDrawer;
  final Function({
    required TaskGroup taskGroup,
    required Function() rebuild,
  }) delete;
  final Function({
    required TaskGroup taskGroup,
    required Function() rebuild,
  }) updateTaskGroup;
  final Function() rebuild;
  TaskGroup taskGroup;
  int groupIndex;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FocusedMenuHolder(
        menuWidth: 150.0,
        // menuOffset: ,
        onPressed: () {},
        menuItems: [
          edit(
            taskGroup: taskGroup,
            updateTaskGroup: updateTaskGroup,
          ),
          deleteButton(
              context: context,
              delete: delete,
              taskGroup: taskGroup,
              rebuild: rebuild),
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
      required Function() rebuild,
    }) delete,
    required TaskGroup taskGroup,
    required Function() rebuild,
  }) {
    return FocusedMenuItem(
      backgroundColor: Colors.red[400],
      trailingIcon: const Icon(Icons.delete),
      title: const Text('Delete'),
      onPressed: () {
        delete(taskGroup: taskGroup, rebuild: rebuild);
        try {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${taskGroup.title} deleted'),
          ));
        } catch (e, s) {
          print(s);
        }
      },
    );
  }

  FocusedMenuItem edit(
      {required Function({
        required TaskGroup taskGroup,
        required Function() rebuild,
      }) updateTaskGroup,
      required TaskGroup taskGroup}) {
    return FocusedMenuItem(
      backgroundColor: const Color(0xFFD5E2DE),
      trailingIcon: const Icon(Icons.edit_rounded),
      title: const Text('Edit'),
      onPressed: () {
        TaskGroupEditButton(
          taskGroup: taskGroup,
          updateTaskGroup: updateTaskGroup,
        );
      },
    );
  }
}
