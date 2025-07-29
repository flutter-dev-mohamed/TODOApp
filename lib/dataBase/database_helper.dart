import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:TODOApp/dataBase/task_class_mod.dart';

class DatabaseHelper {
  DatabaseHelper._init();
  static final DatabaseHelper _helper = DatabaseHelper._init();
  factory DatabaseHelper() => _helper;

  Database? _database;

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'tasks');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT,
        isDone INTEGER
      )
    ''');
  }

  Future<Database?> get database async {
    _database ??= await _initDatabase();
    return _database;
  }

// TODO: get_task from db
  Future<List<Task>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query('tasks');

    return List.generate(maps.length, (i) => Task.fromMap(maps[i]));
  }

// TODO: insert a task into db
  Future<int> insertTask(Task task) async {
    final db = await database;
    return await db!.insert('tasks', task.toMap());
  }

// TODO: delete a task from db
  Future<int> deleteTask(Task task) async {
    final db = await database;
    return await db!.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }

// TODO: update a task in db
  Future<int> updateTask(Task task) async {
    final db = await database;
    return db!.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }
}
