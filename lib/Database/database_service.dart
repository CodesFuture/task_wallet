import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Task {
  final int? taskId;
  final String taskTitle;
  final String description;
  final String dueDate;
  final String priority;
  final String assignee;
  final String status;

  Task({
    this.taskId,
    required this.taskTitle,
    required this.description,
    required this.dueDate,
    required this.priority,
    required this.assignee,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': taskId,
      'taskTitle': taskTitle,
      'description': description,
      'dueDate': dueDate,
      'priority': priority,
      'assignee': assignee,
      'status': status,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      taskId: map['id'],
      taskTitle: map['taskTitle'],
      description: map['description'],
      dueDate: map['dueDate'],
      priority: map['priority'],
      assignee: map['assignee'],
      status: map['status'],
    );
  }

  Task copyWith({
    int? id,
    String? taskTitle,
    String? description,
    String? dueDate,
    String? priority,
    String? assignee,
    String? status,
  }) {
    return Task(
      taskId: id ?? this.taskId,
      taskTitle: taskTitle ?? this.taskTitle,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      assignee: assignee ?? this.assignee,
      status: status ?? this.status,
    );
  }
}

class TaskDatabase {
  static final TaskDatabase instance = TaskDatabase._init();
  static Database? _database;

  TaskDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('tasks.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    print('Database Path: $path');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }
//Done
  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        taskTitle TEXT NOT NULL,
        description TEXT,
        dueDate TEXT NOT NULL,
        priority TEXT NOT NULL,
        assignee TEXT NOT NULL,
        status TEXT NOT NULL
      )
    ''');
    print('Database created and tasks table initialized.');
  }
//Done
  Future<Task> create(Task task) async {
    final db = await instance.database;
    final id = await db.insert('tasks', task.toMap());
    print('Task inserted with ID: $id');
    return task.copyWith(id: id);
  }

  Future<int> update(Task task) async {
    final db = await instance.database;
    final rows = await db.update(
      'tasks',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.taskId],
    );
    print('Task updated. Rows affected: $rows');
    return rows;
  }
  Future<int> delete(int id) async {
    final db = await instance.database;
    final rows = await db.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
    print('Task deleted. Rows affected: $rows');
    return rows;
  }
  Future<List<Task>> getAllTasks() async {
    final db = await instance.database;

    final result = await db.query('tasks');

    return result.map((json) => Task.fromMap(json)).toList();
  }
  Future<void> close() async {
    final db = await instance.database;
    await db.close();
    print('Database closed.');
  }
}
extension TaskExtension on Task {
  Task copyWith({
    int? id,
    String? taskTitle,
    String? description,
    String? dueDate,
    String? priority,
    String? assignee,
    String? status,
  }) {
    return Task(
      taskId: id ?? this.taskId,
      taskTitle: taskTitle ?? this.taskTitle,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      assignee: assignee ?? this.assignee,
      status: status ?? this.status,
    );
  }
}

