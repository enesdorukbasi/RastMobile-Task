import 'package:rastmobile_task_enes_dorukbasi/core/models/todo_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class IToDoService {
  Future<void> createTable(Database database);
  Future<int> insert({
    required String title,
    required String description,
    required String status,
    required String assignee,
    required String date,
  });
  Future<void> delete(int id);
  Future<List<ToDoModel>> fetchAll();
  Future<void> update({
    required String id,
    required String title,
    required String description,
    required String status,
    required String assignee,
    required String date,
  });
}
