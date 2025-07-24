import 'package:uuid/uuid.dart';

class MyTask {
  String title;
  final String id;
  String description;
  bool isChecked = false;

  MyTask({
    required this.title,
    this.description = "",
  }) : id = const Uuid().v4();
}

List<MyTask> listOfTasks = [
  MyTask(
    title: 'Buy groceries',
    description: 'Milk, Bread, Eggs',
  ),
  MyTask(
    title: 'Study Flutter',
    description: 'Widgets, Themes, State Management',
  ),
  MyTask(title: 'Go for a walk'),
  MyTask(
    title: 'Call Mom',
    description: 'Check in and say hello',
  ),
  MyTask(title: 'Clean the room'),
];
