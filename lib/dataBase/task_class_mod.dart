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
  bool isDone;
  bool newTask;

  Task({
    this.id,
    this.newTask = false,
    required this.title,
    this.description = "",
    this.isDone = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isDone': isDone ? 1 : 0,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'],
      id: map['id'],
      description: map['description'],
      isDone: map['isDone'] == 1,
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'TaskId: $id\nisDone: $isDone\ntitle: $title\ndescription: $description';
  }
}
