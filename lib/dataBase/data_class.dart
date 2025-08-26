import 'package:todo_app/dataBase/database_helper.dart';
import 'package:todo_app/dataBase/task_group_class_mod.dart';
import 'package:todo_app/dataBase/task_class_mod.dart';

class Data {
  List<TaskGroup> taskGroupsList = [];
  List<Task> listOfTasks = [];

  Data.init() {}
  static final Data _crud = Data.init();
  factory Data() => _crud;

  DatabaseHelper dbHelper = DatabaseHelper();

  //  ------------------------TaskGroups CRUD------------------------

  Future<List<TaskGroup>> loadTaskGroups() async {
    try {
      final loadedTaskGroups = await dbHelper.getTaskGroup();
      taskGroupsList = loadedTaskGroups;

      return loadedTaskGroups;
    } catch (e) {
      print('-----TaskGroups Data Did Not Load!-----\n$e');
      return [];
    }
  }

  void addTaskGroup({
    required TaskGroup taskGroup,
    required Function() rebuild, // callback function to update the UI
  }) async {
    try {
      await dbHelper.insertTaskGroup(taskGroup);
      print("new Task Group Added!");
      print(taskGroup);
      rebuild();
    } catch (e) {
      print('-----TaskGroup Did Not Get Added-----\n$e');
    }
  }

  void updateTaskGroup({
    required TaskGroup taskGroup,
    required Function() rebuild,
  }) async {
    try {
      await dbHelper.updateTaskGroup(taskGroup);
      print("Task Group Updated!");
      print(taskGroup);
      rebuild();
    } catch (e) {
      print('-----Task Group Did Not Get Updated!-----\n$e');
    }
  }

  void deleteTaskGroup({
    required TaskGroup taskGroup,
    required Function rebuild,
  }) async {
    try {
      await dbHelper.deleteTaskGroup(taskGroup);
      print('Task Group Deleted!');
      print(taskGroup);
      rebuild();
    } catch (e) {
      print('-----TaskGroup DId Not Get Updated!-----\n$e');
    }
  }

  //  ------------------------Task CRUD------------------------

  Future<List<Task>> loadTasks({required int groupId}) async {
    try {
      final loadTasks = await dbHelper.getTasks(groupId: groupId);

      listOfTasks = loadTasks;
      return loadTasks;
    } catch (e) {
      print('\n-----Tasks data did not load-----\n$e');
      return [Task(title: 'Fix Loading Task Data')];
    }
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

    try {
      task.groupId = groupId;
      await dbHelper.insertTask(task);
      rebuild();
      print('-\n\nData_class:\nTask Added\n\n');
    } catch (e) {
      print('Task Did Not Get Added\n$e');
    }
  }

  void deleteTask({
    required Task task,
    required Function() rebuild,
  }) async {
    try {
      await dbHelper.deleteTask(task);
      rebuild();
    } catch (e) {
      print('\n-----Task Did Not Get Deleted-----\n$e');
    }
  }

  void updateTask({
    required Task task,
    required Function() rebuild,
  }) async {
    try {
      await dbHelper.updateTask(task);
      rebuild();
      print('-\n\nData_class:\nTask Updated\n\n');
      print(task);
    } catch (e) {
      print('-----Task Did Not Update-----\n$e');
    }
  }
}
