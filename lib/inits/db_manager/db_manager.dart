// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:rastmobile_task_enes_dorukbasi/core/services/todo_services/i_todo_service.dart';
import 'package:rastmobile_task_enes_dorukbasi/core/services/todo_services/todo_service.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initialize();
    return _database!;
  }

  Future<Database> _initialize() async {
    final path = await fullPath;
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: create,
      singleInstance: true,
    );
    return database;
  }

  Future<void> deleteDatabaseFunc() async {
    String path = await fullPath;
    await deleteDatabase(path);
  }

  Future<void> create(Database database, int version) async {
    IToDoService toDoService = ToDoService();

    toDoService.createTable(database);
  }

  Future<String> get fullPath async {
    const name = "rastmobile.db";
    final path = await getDatabasesPath();
    return join(path, name);
  }
}
