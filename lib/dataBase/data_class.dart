import 'package:TribbianiNotes/dataBase/database_helper.dart';
import 'package:TribbianiNotes/dataBase/task_group_class_mod.dart';
import 'package:TribbianiNotes/dataBase/task_class_mod.dart';

class Data {
  List<TaskGroup> taskGroupsList = [];
  List<Task> listOfTasks = [];

  Data.init() {}
  static final Data _crud = Data.init();
  factory Data() => _crud;

  DatabaseHelper dbHelper = DatabaseHelper();

  //  ------------------------TaskGroups CRUD------------------------

  Future<List<TaskGroup>> loadTaskGroups() async {
    final loadedTaskGroups = await dbHelper.getTaskGroup();
    taskGroupsList = loadedTaskGroups;

    return loadedTaskGroups;
  }

  void addTaskGroup({
    required TaskGroup taskGroup,
    required Function() rebuild, // callback function to update the UI
  }) async {
    await dbHelper.insertTaskGroup(taskGroup);
    rebuild();
  }

  void updateTaskGroup({
    required TaskGroup taskGroup,
    required Function() rebuild,
  }) async {
    await dbHelper.updateTaskGroup(taskGroup);
    rebuild();
  }

  void deleteTaskGroup({
    required TaskGroup taskGroup,
    required Function rebuild,
  }) async {
    await dbHelper.deleteTaskGroup(taskGroup);
    rebuild();
  }

  //  ------------------------Task CRUD------------------------

  Future<List<Task>> loadTasks({required int groupId}) async {
    final loadTasks = await dbHelper.getTasks(groupId: groupId);

    listOfTasks = loadTasks;
    return loadTasks;
  }

  void addTask({
    required Task task,
    required int groupId,
    required Function() rebuild, // callback function to update the UI
  }) async {
    // empty task -> return
    if (task.title.isEmpty && task.description.isEmpty) return;

    // missing title
    if (task.title.isEmpty && task.description.isNotEmpty) {
      task.title = 'New Reminder';
    }

    task.groupId = groupId;
    int insertId = await dbHelper.insertTask(task);
    task.id = insertId;
    rebuild();
  }

  void deleteTask({
    required Task task,
    required Function() rebuild,
  }) async {
    await dbHelper.deleteTask(task);
    rebuild();
  }

  void updateTask({
    required Task task,
    required Function() rebuild,
  }) async {
    await dbHelper.updateTask(task);
    rebuild();
  }
}
