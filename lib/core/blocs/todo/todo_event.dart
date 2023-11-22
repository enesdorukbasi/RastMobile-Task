part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

class FetchAllTodos extends TodoEvent {}

class GenerateTodo extends TodoEvent {
  final String title;
  final String description;
  final String status;
  final String assignee;
  final BuildContext context;
  final TodoBloc bloc;

  GenerateTodo({
    required this.title,
    required this.description,
    required this.status,
    required this.assignee,
    required this.context,
    required this.bloc,
  });
}
