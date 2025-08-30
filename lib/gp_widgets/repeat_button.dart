import 'package:flutter/material.dart';
import 'package:todo_app/Pages/repeat_page.dart';
import 'package:todo_app/dataBase/task_class_mod.dart';

class RepeatButton extends StatefulWidget {
  RepeatButton({super.key, required this.task});
  Task task;

  @override
  State<RepeatButton> createState() => _RepeatButtonState();
}

class _RepeatButtonState extends State<RepeatButton> {
  late ColorScheme theme;

  void rebuildRepeatButton(Function func) {
    setState(() {
      func();
    });
  }

  @override
  Widget build(BuildContext context) {
    theme = Theme.of(context).colorScheme;
    return ListTile(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16)),
      tileColor: theme.secondaryContainer,
      title: const Text('Repeat'),
      leading: leadingIcon(),
      trailing: trailing(),
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => RepeatPage(
                task: widget.task, rebuildRepeatButton: rebuildRepeatButton),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          ),
        );
      },
    );
  }

  Widget leadingIcon() {
    return SizedBox(
      width: 30,
      height: 30,
      child: Material(
        borderRadius: BorderRadius.circular(5.5),
        color: theme.surfaceContainer,
        elevation: 1,
        child: Icon(
          Icons.event_repeat,
          color: Colors.deepPurple[300],
        ),
      ),
    );
  }

  Widget trailing() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.task.repeat.name,
          style: const TextStyle(fontSize: 15),
        ),
        const Icon(Icons.chevron_right_rounded),
      ],
    );
  }
}
