// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously, unnecessary_import

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:rastmobile_task_enes_dorukbasi/core/models/todo_model.dart';
import 'package:rastmobile_task_enes_dorukbasi/core/services/todo_services/i_todo_service.dart';
import 'package:rastmobile_task_enes_dorukbasi/inits/cache_manager/cache_manager.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final IToDoService _toDoService;
  TodoBloc(this._toDoService) : super(TodoInitializing()) {
    on<FetchAllTodos>((event, emit) async {
      try {
        emit(TodoInitializing());
        List<ToDoModel> todos = await _toDoService.fetchAll();
        if (todos.isEmpty) {
          emit(TodoInitialError("No To Do found. Please add."));
        } else {
          List<ToDoModel> backlogTodos =
              todos.where((element) => element.status == "Backlog").toList();
          List<ToDoModel> normalTodos =
              todos.where((element) => element.status == "To Do").toList();
          List<ToDoModel> inProgressTodos = todos
              .where((element) => element.status == "In Progress")
              .toList();
          List<ToDoModel> doneTodos =
              todos.where((element) => element.status == "Done").toList();
          List<String> cachedTodos = await CacheManager.getCachedTodoModels();

          emit(
            TodoInitialized(
              normalTodos,
              inProgressTodos,
              backlogTodos,
              doneTodos,
              todos,
              cachedTodos,
            ),
          );
        }
      } catch (ex) {
        emit(TodoInitialError("A problem was encountered."));
      }
    });
    on<GenerateTodo>((event, emit) async {
      try {
        emit(GeneratingTodo());
        String date =
            "${DateTime.now().day}.${DateTime.now().month}.${DateTime.now().year}";
        await _toDoService.insert(
          title: event.title,
          description: event.description,
          status: event.status,
          assignee: event.assignee,
          date: date,
        );
        emit(GeneratedTodo());
        Navigator.pop(event.context);
        event.bloc.add(FetchAllTodos());
      } catch (ex) {
        emit(GenerateErrorTodo());
      }
    });
  }
}
