import 'package:rastmobile_task_enes_dorukbasi/core/models/todo_model.dart';
import 'package:rastmobile_task_enes_dorukbasi/core/services/todo_services/i_todo_service.dart';
import 'package:rastmobile_task_enes_dorukbasi/inits/db_manager/db_manager.dart';
import 'package:sqflite/sqflite.dart';

class ToDoService extends IToDoService {
  final String _tableName = "todoTable";

  @override
  Future<void> createTable(Database database) async {
    await database.execute(
      """CREATE TABLE IF NOT EXISTS $_tableName (
      "id" INTEGER NOT NULL,
      "title" TEXT NOT NULL,
      "description" TEXT NOT NULL,
      "status" TEXT NOT NULL,
      "assignee" TEXT NOT NULL,
      "date" TEXT NOT NULL,
      PRIMARY KEY("id" AUTOINCREMENT)
    );""",
    );
  }

  @override
  Future<int> insert({
    required String title,
    required String description,
    required String status,
    required String assignee,
    required String date,
  }) async {
    final database = await DatabaseManager().database;
    return await database.rawInsert(
      '''INSERT INTO $_tableName (title, description, status, assignee, date) VALUES (?,?,?,?,?)''',
      [title, description, status, assignee, date],
    );
  }

  @override
  Future<void> delete(int id) async {
    final database = await DatabaseManager().database;
    await database.rawDelete('''DELETE FROM $_tableName WHERE id = ?''', [id]);
  }

  @override
  Future<List<ToDoModel>> fetchAll() async {
    final database = await DatabaseManager().database;
    final items = await database.rawQuery('''SELECT * FROM $_tableName''');
    return items.map((e) => ToDoModel.fromMap(e)).toList();
  }

  @override
  Future<void> update(
      {required String id,
      required String title,
      required String description,
      required String status,
      required String assignee,
      required String date}) async {
    final database = await DatabaseManager().database;
    await database.rawUpdate(
      'UPDATE $_tableName SET title = "$title", description = "$description", status = "$status", assignee = "$assignee" WHERE id = $id',
    );
  }
}
