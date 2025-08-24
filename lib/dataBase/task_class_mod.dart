class Task {
  String title;
  final int? id;
  late int? groupId;
  String description;
  bool isDone;
  bool newTask;
  String? _date;
  String? _time;
  bool hasDate;
  bool hasTime;

  Task({
    this.id,
    this.groupId,
    this.newTask = false,
    required this.title,
    this.description = "",
    this.isDone = false,
    String? date,
    this.hasDate = false,
    String? time,
    this.hasTime = false,
  })  : _date = date,
        _time = time;

  set date(String? setDate) {
    // if hasDate -> true & hasTime true
    if (setDate != null) {
      _date = setDate;
      hasDate = true;
      if (!hasTime) {
        // if hasDate -> true & hasTime false
        _time = '00:00';
        hasTime = true;
      }
    }

    if (setDate == null) {
      // no date => no time
      hasDate = false;
      _date = setDate;
      hasTime = false;
      _time = null;
    }
  }

  set time(String? setTime) {
    // if hasTime -> true & hasDate true
    if (setTime != null) {
      hasTime = true;
      _time = setTime;

      if (!hasDate) {
        // if hasTime -> true & hasDate false
        _date =
            '${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}';
        hasDate = true;
      }
    }

    if (setTime == null) {
      _time = '00:00';
      hasTime = false;
    }
  }

  String? get time => _time;
  String? get date => _date;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'groupId': groupId,
      'title': title,
      'description': description,
      'isDone': isDone ? 1 : 0,
      'date': _date,
      'time': _time,
      'hasTime': hasTime ? 1 : 0,
      'hasDate': hasDate ? 1 : 0,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      groupId: map['groupId'],
      title: map['title'],
      description: map['description'],
      isDone: map['isDone'] == 1,
      date: map['date'],
      time: map['time'],
      hasDate: map['hasDate'] == 1,
      hasTime: map['hasTime'] == 1,
    );
  }

  @override
  String toString() {
    return 'TaskId: $id\nGroupID: $groupId\nisDone: $isDone\ntitle: $title\nnewTask: $newTask\ndescription: $description\nDate: $date\ntime: $time';
  }
}
