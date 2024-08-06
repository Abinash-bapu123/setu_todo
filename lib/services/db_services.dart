import 'dart:async';
import 'package:setu_todo/models/journal_model.dart';
import 'package:setu_todo/models/todo_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static final DbHelper _instance = DbHelper._internal();
  static Database? _database;

  factory DbHelper() => _instance;

  DbHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'todo.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE todo(
            id INTEGER PRIMARY KEY,
            todoItem TEXT,
            createdDate TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE journal(
            id INTEGER PRIMARY KEY,
            journal TEXT,
            createdDate TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertJournal(JournalModel journal) async {
    final db = await database;
    await db.insert('journal', journal.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<JournalModel> getJournal() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('journal');
    if (maps.isEmpty) {
      return JournalModel.fromJson({});
    } else {
      return JournalModel.fromJson(maps[0]);
    }
  }

  Future<void> updateJournal(JournalModel journal, int id) async {
    final db = await database;
    await db
        .update("journal", journal.toJson(), where: "id = ?", whereArgs: [id]);
  }

  Future<void> insertTodo(TodoModel todo) async {
    final db = await database;
    db.insert('todo', todo.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> removeTodo(int id) async {
    final db = await database;
    await db.delete("todo", where: "id = ?", whereArgs: [id]);
  }

  Future<List<TodoModel>> getTodos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('todo');
    return List.generate(maps.length, (i) {
      return TodoModel.fromJson(maps[i]);
    });
  }

  Future<void> clearRepositories() async {
    final db = await database;
    await db.delete('todo');
  }
}
