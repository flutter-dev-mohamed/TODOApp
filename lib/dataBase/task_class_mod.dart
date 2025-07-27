import 'package:uuid/uuid.dart';

List<String> months = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December"
];

//
//
//
//
//

class Task {
  String title;
  final int? id;
  String description;
  String lastEdit;
  bool isDone = false;

  Task({
    this.id,
    required this.title,
    this.description = "",
    this.lastEdit = "add the lastEdit!",
  });
  // lastEdit = "${DateTime.now().day} ${months[DateTime.now().month - 1]} ${DateTime.now().year} at ${DateTime.now().hour}:${DateTime.now().minute}";

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'lasEdit': lastEdit,
      'isDone': isDone,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'],
      id: map['id'],
      description: map['description'],
      lastEdit: map['lastEdit'],
    );
  }
}

//
//
//
//
//
List<Task> listOfTasks = [
  Task(
    title: 'Buy groceries',
    description: 'Milk, Bread, Eggs',
  ),
  Task(
    title: 'Study Flutter',
    description: 'Widgets, Themes, State Management',
  ),
  Task(title: 'Go for a walk'),
  Task(
    title: 'Call Mom',
    description: 'Check in and say hello',
  ),
  Task(title: 'Clean the room'),
];
