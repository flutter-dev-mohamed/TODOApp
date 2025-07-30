class TaskGroup {
  String title;
  int? id;
  bool newTaskGroup;

  TaskGroup({
    this.id,
    required this.title,
    this.newTaskGroup = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
    };
  }

  factory TaskGroup.fromMap(Map<String, dynamic> map) {
    return TaskGroup(
      title: map['title'],
      id: map['id'],
    );
  }

  @override
  String toString() {
    return 'TaskGroup: \ntitle: $title\nID: $id';
  }
}
