import 'package:todo_app/dataBase/database_helper.dart';
import 'package:todo_app/dataBase/task_group_class_mod.dart';
import 'package:todo_app/dataBase/task_class_mod.dart';

class Data {
  List<TaskGroup> taskGroupsList = [TaskGroup(title: 'Default TaskGroup')];
  List<Task> listOfTasks = [Task(title: 'Default Task')];

  Data.init() {
    print('Data init!');
  }
  static final Data _crud = Data.init();
  factory Data() => _crud;

  DatabaseHelper dbHelper = DatabaseHelper();

  //  ------------------------TaskGroups CRUD------------------------
  Future<List<TaskGroup>> loadTaskGroups() async {
    try {
      final loadedTaskGroups = await dbHelper.getTaskGroup();
      print('taskGroup dataLoaded');
      taskGroupsList = loadedTaskGroups;
      print(taskGroupsList);

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
      print('tasks data is Loading...');
      final loadTasks = await dbHelper.getTasks(groupId: groupId);

      listOfTasks = loadTasks;
      if (listOfTasks.length == 0) {
        print(
            '\n-------------------------------the fucking list is fucking empty-------------------------------------\n');
        print(
            '\n-------------------------------the fucking list is fucking empty-------------------------------------\n');
        print(
            '\n-------------------------------the fucking list is fucking empty-------------------------------------\n');
        print(
            '\n-------------------------------the fucking list is fucking empty-------------------------------------\n');
      }
      print('Tasks loaded!');
      print(loadTasks);
      print(listOfTasks);
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
    try {
      print('---------Adding Your Task');
      task.groupId = groupId;
      print(task);
      await dbHelper.insertTask(task);
      print('Task Added:');
      rebuild();
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
      print('Task Deleted: ');
      print(task);
      rebuild();
    } catch (e) {
      print('-----Task Did Not Get Deleted-----\n$e');
    }
  }

  void updateTask({
    required Task task,
    required Function() rebuild,
  }) async {
    try {
      print(
          'updateTask: taskId: ${task.id} TaskGroupId: ${task.groupId} isDone: ${task.isDone}');
      await dbHelper.updateTask(task);
      rebuild();
    } catch (e) {
      print('-----Task Did Not Update-----\n$e');
    }
  }
}
