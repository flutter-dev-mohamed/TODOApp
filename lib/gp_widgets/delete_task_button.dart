import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class DeleteTaskButton extends StatelessWidget {
  DeleteTaskButton({
    super.key,
    required this.delete,
    required this.undoDeleteTask,
  });
  final Function() delete;
  final Function() undoDeleteTask;

  late ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
      scaffoldFeatureController;

  @override
  Widget build(BuildContext context) {
    return SlidableAction(
      backgroundColor: Theme.of(context).colorScheme.errorContainer,
      foregroundColor: Theme.of(context).colorScheme.error,
      borderRadius: BorderRadius.circular(12),
      autoClose: true,
      icon: Icons.delete_rounded,
      label: 'Delete',
      onPressed: (context) {
        delete();
        scaffoldFeatureController = ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Task deleted',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onTertiaryContainer,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    undoDeleteTask();
                    scaffoldFeatureController.close();
                  },
                  child: Text(
                    'Undo',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
