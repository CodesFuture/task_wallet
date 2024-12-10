import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'database_model.dart';

class TaskDatabase {
  static final TaskDatabase instance = TaskDatabase._init();
  static Database? _database;

  TaskDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('task_wallet.db');
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

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE task_wallet (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        taskTitle TEXT NOT NULL,
        description TEXT,
        dueDate TEXT NOT NULL,
        priority TEXT NOT NULL,
        assignee TEXT NOT NULL,
        status TEXT NOT NULL,
        time TEXT NOT NULL
      )
    ''');
    print('Database created and tasks table initialized.');
  }

  Future<Task> create(Task task) async {
    final db = await instance.database;
    final id = await db.insert('task_wallet', task.toMap());
    print('Task inserted with ID: $id');
    return task.copyWith(id: id);
  }

  Future<int> update(Task task) async {
    final db = await instance.database;
    final rows = await db.update(
      'task_wallet',
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
      'task_wallet',
      where: 'id = ?',
      whereArgs: [id],
    );
    print('Task deleted. Rows affected: $rows');
    return rows;
  }

  Future<List<Task>> getAllTasks() async {
    final db = await instance.database;

    final result = await db.query('task_wallet');

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
    TimeOfDay? time,
  }) {
    return Task(
      taskId: id ?? this.taskId,
      taskTitle: taskTitle ?? this.taskTitle,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      assignee: assignee ?? this.assignee,
      status: status ?? this.status,
      time: time ?? this.time,
    );
  }
}
