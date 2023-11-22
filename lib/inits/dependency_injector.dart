import 'package:rastmobile_task_enes_dorukbasi/core/blocs/todo/todo_bloc.dart';
import 'package:rastmobile_task_enes_dorukbasi/core/services/todo_services/i_todo_service.dart';
import 'package:rastmobile_task_enes_dorukbasi/core/services/todo_services/todo_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DependencyInjector {
  static DependencyInjector? _instance;

  static DependencyInjector get instance {
    _instance ??= DependencyInjector._init();
    return _instance!;
  }

  //Services
  late final IToDoService _toDoService;
  //Blocs
  late final TodoBloc _todoBloc;

  DependencyInjector._init() {
    _toDoService = ToDoService();
    _todoBloc = TodoBloc(_toDoService);
  }

  List<BlocProvider<Bloc>> get blocProviders => [
        BlocProvider<TodoBloc>(create: (context) => _todoBloc),
      ];
}
