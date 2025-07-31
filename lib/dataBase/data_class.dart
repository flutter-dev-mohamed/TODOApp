import 'package:todo_app/dataBase/database_helper.dart';
import 'package:todo_app/dataBase/task_group_class_mod.dart';
import 'package:todo_app/dataBase/task_class_mod.dart';

class Data {
  List<TaskGroup> taskGroupsList = [TaskGroup(title: 'title')];
  List<Task> listOfTasks = [];
  int groupId = 0;

  Data.init() {
    loadTaskGroups();
    loadTasks();
    print('Data init!');
  }
  static final Data _crud = Data.init();
  factory Data() => _crud;

  DatabaseHelper dbHelper = DatabaseHelper();

  //  ------------------------TaskGroups CRUD------------------------
  Future<List<TaskGroup>> loadTaskGroups() async {
    final loadedTaskGroups = await dbHelper.getTaskGroup();
    print(taskGroupsList);
    return loadedTaskGroups;
  }

  void addTaskGroup(TaskGroup taskGroup) async {
    await dbHelper.insertTaskGroup(taskGroup);
    print("new Task Group Added!");
    print(taskGroup);
  }

  void updateTaskGroup(TaskGroup taskGroup) async {
    await dbHelper.updateTaskGroup(taskGroup);
    print("Task Group Updated!");
    print(taskGroup);
  }

  void deleteTaskGroup(TaskGroup taskGroup) async {
    await dbHelper.deleteTaskGroup(taskGroup);
    print('Task Group Deleted!');
    print(taskGroup);
  }

  //  ------------------------Task CRUD------------------------
  Future<List<Task>> loadTasks() async {
    final loadTasks = await dbHelper.getTasks(groupId: groupId);

    listOfTasks = loadTasks;
    print('Tasks loaded!');
    print(loadTasks);
    print(listOfTasks);
    return loadTasks;
  }

  void addTask(Task task) async {
    print('Task Added:');
    print(task);
    await dbHelper.insertTask(task);
    loadTasks();
  }

  void deleteTask(Task task) async {
    print('Task Deleted: ');
    print(task);
    await dbHelper.deleteTask(task);
    loadTasks();
  }

  void updateTask(Task task) async {
    print(
        'updateTask: taskId: ${task.id} TaskGroupId: ${task.groupId} isDone: ${task.isDone}');
    await dbHelper.updateTask(task);
    loadTasks();
  }
}
