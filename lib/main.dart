import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:rastmobile_task_enes_dorukbasi/inits/base_singleton.dart';
import 'package:rastmobile_task_enes_dorukbasi/inits/dependency_injector.dart';
import 'package:rastmobile_task_enes_dorukbasi/utils/extensions/string_extensions.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: DependencyInjector.instance.blocProviders,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget with BaseSingleton {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (p0, p1, p2) {
        return GetMaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'RastMobile-Task',
          theme: ThemeData(
            primaryColor: "#744BFC".toColor(),
          ),
          routeInformationParser: routeManager.routes.routeInformationParser,
          routerDelegate: routeManager.routes.routerDelegate,
          routeInformationProvider:
              routeManager.routes.routeInformationProvider,
        );
      },
    );
  }
}
