import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/dataBase/task_class_mod.dart';

class DeleteTaskButton extends StatelessWidget {
  DeleteTaskButton({
    super.key,
    required this.delete,
    required this.undoDeleteTask,
  });
  final Function() delete;
  final Function() undoDeleteTask;

  @override
  Widget build(BuildContext context) {
    return SlidableAction(
      onPressed: (context) {
        delete();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Task deleted'),
                TextButton(
                  onPressed: () {
                    undoDeleteTask();
                  },
                  child: const Text('Undo'),
                ),
              ],
            ),
          ),
        );
      },
      backgroundColor: const Color(0xFFD5E2DE),
      foregroundColor: Colors.red[400],
      borderRadius: BorderRadius.circular(12),
      autoClose: true,
      icon: Icons.delete_rounded,
      label: 'Delete',
    );
  }
}
