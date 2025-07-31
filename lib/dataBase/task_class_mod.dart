class Task {
  String title;
  final int? id;
  final int? groupId;
  String description;
  bool isDone;
  bool newTask;

  Task({
    this.id,
    this.groupId,
    this.newTask = false,
    required this.title,
    this.description = "",
    this.isDone = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'groupId': groupId,
      'title': title,
      'description': description,
      'isDone': isDone ? 1 : 0,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      groupId: map['groupId'],
      title: map['title'],
      description: map['description'],
      isDone: map['isDone'] == 1,
    );
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'TaskId: $id\nGroupID: $groupId\nisDone: $isDone\ntitle: $title\nnewTask: $newTask\ndescription: $description';
  }
}
