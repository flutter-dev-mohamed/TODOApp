import 'package:flutter/material.dart';
import 'package:TribbianiNotes/Pages/date_and_time.dart';
import 'package:TribbianiNotes/dataBase/data_class.dart';
import 'package:TribbianiNotes/dataBase/task_class_mod.dart';

class CustomBottomSheet extends StatefulWidget {
  CustomBottomSheet({
    super.key,
    required this.task,
    required this.data,
    required this.rebuildHomePage,
  });
  Task task;
  Data data;
  final Function() rebuildHomePage;

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  void updateTask() {
    widget.data.updateTask(task: widget.task, rebuild: widget.rebuildHomePage);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .secondaryContainer
            .withValues(alpha: 0.8),
        borderRadius: const BorderRadius.all(Radius.zero),
      ),
      child: Row(
        children: [dateButton()],
      ),
    );
  }

  Widget dateButton() {
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return SafeArea(
              top: true,
              child: DraggableScrollableSheet(
                expand: false,
                initialChildSize: 0.9,
                builder: (context, scrollController) {
                  return Navigator(
                    onGenerateRoute: (settings) {
                      return MaterialPageRoute(
                        builder: (context) {
                          return DateAndTime(
                            taskToEditDate: widget.task,
                            updateTask: updateTask,
                          );
                        },
                      );
                    },
                  );
                },
              ),
            );
          },
        );
      },
      icon: const Icon(Icons.event),
      color: Theme.of(context).colorScheme.primary,
    );
  }
}
