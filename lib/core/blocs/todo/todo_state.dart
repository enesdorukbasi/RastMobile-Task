part of 'todo_bloc.dart';

@immutable
sealed class TodoState {}

final class TodoInitializing extends TodoState {}

final class TodoInitialized extends TodoState {
  final List<ToDoModel> normalTodos;
  final List<ToDoModel> inProgressTodos;
  final List<ToDoModel> backlogTodos;
  final List<ToDoModel> doneTodos;
  final List<ToDoModel> todos;
  final List<String> cachedTodos;

  TodoInitialized(
    this.normalTodos,
    this.inProgressTodos,
    this.backlogTodos,
    this.doneTodos,
    this.todos,
    this.cachedTodos,
  );
}

final class TodoInitialError extends TodoState {
  final String errorMessage;

  TodoInitialError(this.errorMessage);
}

final class GeneratingTodo extends TodoState {}

final class GeneratedTodo extends TodoState {}

final class GenerateErrorTodo extends TodoState {}
