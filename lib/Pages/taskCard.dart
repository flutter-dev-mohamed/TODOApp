import 'package:flutter/material.dart';
import '../dataBase/dataBase.dart';

const TextStyle titleTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18,
);
const TextStyle subTitleStyle = TextStyle(
  fontSize: 13,
);

class Taskcard extends StatelessWidget {
  Taskcard({super.key, required this.task});

  MyTask task;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(task.ID),
      child: Expanded(
        child: ListTile(
          //  TODO: Add the onTap push -> TaskPage
          title: Text(
            task.title,
            style: titleTextStyle,
          ),
          subtitle: Text(
            task.description,
            style: subTitleStyle,
          ),
        ),
      ),
    );
  }
}
