import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:TODOApp/dataBase/task_class_mod.dart';
import 'package:TODOApp/dataBase/task_group_class_mod.dart';

class DatabaseHelper {
  DatabaseHelper._init();
  static final DatabaseHelper _helper = DatabaseHelper._init();
  factory DatabaseHelper() => _helper;

  Database? _database;

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'tasks.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate,
        onConfigure: (Database db) async {
      await db.execute('PRAGMA foreign_keys = ON');
    });
  }

  Future<void> _onCreate(Database db, int version) async {
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
    insertTaskGroup(TaskGroup(title: "ToDo"));
  }

  Future<Database?> get database async {
    _database ??= await _initDatabase();
    return _database;
  }

// get_task from db
  Future<List<Task>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> taskMaps = await db!.query('tasks');

    return List.generate(taskMaps.length, (i) => Task.fromMap(taskMaps[i]));
  }

// get_taskGroup from db
  Future<List<TaskGroup>> getTaskGroup() async {
    final db = await database;
    final List<Map<String, dynamic>> groupMaps = await db!.query('task_group');

    return List.generate(
        groupMaps.length, (i) => TaskGroup.fromMap(groupMaps[i]));
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
    ;
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
