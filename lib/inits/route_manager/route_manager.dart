import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rastmobile_task_enes_dorukbasi/core/functions/base_functions.dart';
import 'package:rastmobile_task_enes_dorukbasi/core/models/todo_model.dart';
import 'package:rastmobile_task_enes_dorukbasi/ui/details/details_page.dart';
import 'package:rastmobile_task_enes_dorukbasi/ui/general/splash_page.dart';
import 'package:rastmobile_task_enes_dorukbasi/ui/home_page/home_page.dart';
import 'package:rastmobile_task_enes_dorukbasi/utils/enums/route_enums.dart';

final GlobalKey<NavigatorState> mainNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'main');
final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

class RouteManager {
  static RouteManager? _instance;

  static RouteManager get instance {
    _instance ??= RouteManager._init();
    return _instance!;
  }

  RouteManager._init();

  GoRouter routes = GoRouter(
    debugLogDiagnostics: true,
    navigatorKey: rootNavigatorKey,
    initialLocation: RouteEnums.splash.routeName,
    routes: <RouteBase>[
      GoRoute(
        path: RouteEnums.splash.routeName,
        pageBuilder: (context, state) {
          return BaseFunctions.instance.animatedRouting(
            state: state,
            route: const SplashPage(),
          );
        },
      ),
      GoRoute(
        path: RouteEnums.home.routeName,
        pageBuilder: (context, state) {
          return BaseFunctions.instance.animatedRouting(
            state: state,
            route: const HomePage(),
          );
        },
      ),
      GoRoute(
        path: RouteEnums.details.routeName,
        pageBuilder: (context, state) {
          late ToDoModel model;
          try {
            model = state.extra as ToDoModel;
          } catch (ex) {
            model = ToDoModel.fromJson(state.extra as String);
          }
          return BaseFunctions.instance.animatedRouting(
            state: state,
            route: DetailsPage(model: model),
          );
        },
      ),
    ],
  );
}
