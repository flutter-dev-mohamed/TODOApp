import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_app/dataBase/task_class_mod.dart';
import 'package:todo_app/dataBase/task_group_class_mod.dart';

class DatabaseHelper {
  DatabaseHelper._init();
  static final DatabaseHelper _helper = DatabaseHelper._init();
  factory DatabaseHelper() => _helper;

  Database? _database;

  Future<Database?> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'tasks.db');
    //
    // print('--------------------------Path------------------------');
    // print(path);
    // print('--------------------------Path------------------------');
    try {
      return await openDatabase(
        path,
        version: 1,
        onConfigure: _onConfigure,
        onCreate: _onCreate,
      );
    } catch (e) {
      print(
          '____________________Database did not open!____________________\n$e');
    }
  }

  Future<void> _onConfigure(Database db) async {
    print('_onConfigure');
    await db.execute('PRAGMA foreign_keys = ON');
    print('-----------------------done config-----------------');
  }

  Future<void> _onCreate(Database db, int version) async {
    print('_onCreate');
    await db.execute('''
    CREATE TABLE task_group(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE tasks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        isDone INTEGER,
        groupId INTEGER,
        FOREIGN KEY (groupId) REFERENCES task_group(id) ON DELETE CASCADE
      )
    ''');
    print(
        '----------------------------------done creating-----------------------');
  }

  Future<Database?> get database async {
    _database ??= await _initDatabase();

    return _database;
  }

// get_task from db
  Future<List<Task>> getTasks({required int groupId}) async {
    final db = await database;
    final List<Map<String, dynamic>> taskMaps = await db!.query(
      'tasks',
      where: 'groupId = ?',
      whereArgs: [groupId],
    );

    return List.generate(taskMaps.length, (i) => Task.fromMap(taskMaps[i]));
  }

// get_taskGroup from db
  Future<List<TaskGroup>> getTaskGroup() async {
    final db = await database;
    List<Map<String, dynamic>> groupMaps = await db!.query('task_group');

    if (groupMaps.isEmpty) {
      try {
        print('--groupTasks is Empty--');
        await insertTaskGroup(TaskGroup(title: 'ToDo'));
        groupMaps = await db!.query('task_group');
      } catch (e) {
        print('groupTasks is empty ---TaskGroup--- not inserted\n$e');
      }
    }
    List<TaskGroup> result =
        List.generate(groupMaps.length, (i) => TaskGroup.fromMap(groupMaps[i]));
    print(
        '\n\n----------------------------------getTaskGroups--------------------------\n\n');
    print(result);
    print(
        '\n\n----------------------------------getTaskGroups--------------------------\n\n');
    return result;
  }

// insert a task into db
  Future<int> insertTask(Task task) async {
    final db = await database;
    return await db!.insert('tasks', task.toMap());
  }

// insert a taskGroup into db
  Future<int> insertTaskGroup(TaskGroup taskGroup) async {
    final db = await database;
    return await db!.insert('task_group', taskGroup.toMap());
  }

// delete a task from db
  Future<int> deleteTask(Task task) async {
    final db = await database;
    return await db!.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

// delete a taskGroup from db
  Future<int> deleteTaskGroup(TaskGroup taskGroup) async {
    final db = await database;
    return await db!.delete(
      'task_group',
      where: 'id = ?',
      whereArgs: [taskGroup.id],
    );
  }

// update a task in db
  Future<int> updateTask(Task task) async {
    final db = await database;
    return db!.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

// update taskGroup in db
  Future<int> updateTaskGroup(TaskGroup taskGroup) async {
    final db = await database;
    return db!.update(
      'task_group',
      taskGroup.toMap(),
      where: 'id = ?',
      whereArgs: [taskGroup.id],
    );
  }
}
