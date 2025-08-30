import 'package:flutter/material.dart';
import 'package:todo_app/dataBase/task_class_mod.dart';
import 'package:todo_app/settings/settings.dart';

class RepeatPage extends StatefulWidget {
  RepeatPage(
      {super.key, required this.task, required this.rebuildRepeatButton});
  Task task;
  final Function(Function func) rebuildRepeatButton;
  @override
  State<RepeatPage> createState() => _RepeatPageState();
}

class _RepeatPageState extends State<RepeatPage> {
  final options = Repeat.values;

  @override
  Widget build(BuildContext context) {
    Decoration decoration = BoxDecoration(
      borderRadius: BorderRadiusGeometry.circular(28),
      color: Theme.of(context).colorScheme.surfaceContainerLow,
    );

    ColorScheme theme = Theme.of(context).colorScheme;

    return Container(
      decoration: decoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          customAppBar(theme),
          optionsPicker(theme),
        ],
      ),
    );
  }

  Widget customAppBar(ColorScheme theme) {
    return AppBar(
      title: Text('Repeat', style: TextStyle(color: theme.primary)),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      leadingWidth: 140,
      leading: TextButton.icon(
        onPressed: () {
          Navigator.of(context).pop();
        },
        label: Text(
          'Date&Time',
          style: TextStyle(color: theme.primary),
          maxLines: 1,
        ),
        icon: Icon(Icons.chevron_left_rounded, color: theme.primary, size: 30),
      ),
    );
  }

  Widget optionsPicker(ColorScheme theme) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Container(
        decoration: BoxDecoration(
          color: theme.secondaryContainer,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: options.length,
          itemBuilder: (context, index) {
            final option = options[index];
            return ListTile(
              title: Text(option.name),
              onTap: () {
                widget.task.repeat = option;
                widget.rebuildRepeatButton(() {});
                Navigator.of(context).pop();
              },
            );
          },
          separatorBuilder: (context, index) => Divider(
            height: 0,
            color: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
        ),
      ),
    );
  }
}
