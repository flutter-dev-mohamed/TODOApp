import 'package:uuid/uuid.dart';

class MyTask {
  String title;
  final String ID;
  String description;
  bool checked = false;

  MyTask({
    required this.title,
    this.description = "",
  }) : ID = const Uuid().v4();

  void check() {
    this.checked = true;
  }

  void Uncheck() {
    this.checked = false;
  }
}

List<MyTask> tasks = [
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
