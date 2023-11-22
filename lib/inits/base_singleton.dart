import 'package:rastmobile_task_enes_dorukbasi/core/functions/base_functions.dart';
import 'package:rastmobile_task_enes_dorukbasi/inits/route_manager/route_manager.dart';

mixin BaseSingleton {
  RouteManager get routeManager => RouteManager.instance;
  BaseFunctions get functions => BaseFunctions.instance;
}
