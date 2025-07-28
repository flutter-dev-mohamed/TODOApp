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
    String? lastEdit,
  }) : lastEdit = lastEdit ??
            "${DateTime.now().day} ${months[DateTime.now().month - 1]} ${DateTime.now().year} at ${DateTime.now().hour}:${DateTime.now().minute}";

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'lastEdit': lastEdit,
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
