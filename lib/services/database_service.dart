import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_app/models/task_model.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initialDb('tasks.db');
    return _database!;
  }

  Future<Database> _initialDb(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int versoin) async {
    await db.execute('''CREATE TABLE tasks(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        dateTime TEXT NOT NULL,
        isCompleted INTEGER NOT NULL
      )
''');
  }

  Future<int> createTask(TaskModel task) async {
    final db = await instance.database;
    return await db.insert('tasks', task.toMap());
  }

  Future<TaskModel?> getTask(int id) async {
    final db = await instance.database;
    final maps = await db.query(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return TaskModel.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<List<TaskModel>> getAllTasks() async {
    final db = await instance.database;
    final result = await db.query('tasks');
    return result.map((map) => TaskModel.fromMap(map)).toList();
  }
  Future<int> updateTask(TaskModel task) async {
    final db = await instance.database;
    return await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
  }
 Future<int> deleteTask(int id) async {
    final db = await instance.database;
    return await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }


}
