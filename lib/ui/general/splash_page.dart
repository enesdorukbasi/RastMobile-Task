// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rastmobile_task_enes_dorukbasi/utils/enums/route_enums.dart';
import 'package:rastmobile_task_enes_dorukbasi/utils/extensions/num_extensions.dart';
import 'package:rastmobile_task_enes_dorukbasi/utils/extensions/string_extensions.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () => context.go(RouteEnums.home.routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //Top
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: (MediaQuery.of(context).size.width / 4) * 0.95,
              height: (MediaQuery.of(context).size.width / 4) * 0.95,
              decoration: BoxDecoration(
                color: "#744BFC".toColor(),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              width: (MediaQuery.of(context).size.width / 4) * 2.95,
              height: (MediaQuery.of(context).size.width / 4) * 0.95,
              decoration: BoxDecoration(
                color: "#744BFC".toColor(),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: (MediaQuery.of(context).size.width / 4) * 1,
            child: Container(
              width: (MediaQuery.of(context).size.width / 4) * 0.95,
              height: (MediaQuery.of(context).size.width / 4) * 1.95,
              decoration: BoxDecoration(
                color: "#744BFC".toColor(),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
            ),
          ),
          //Bottom
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: (MediaQuery.of(context).size.width / 4) * 0.95,
              height: (MediaQuery.of(context).size.width / 4) * 0.95,
              decoration: BoxDecoration(
                color: "#744BFC".toColor(),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: Container(
              width: (MediaQuery.of(context).size.width / 4) * 2.95,
              height: (MediaQuery.of(context).size.width / 4) * 0.95,
              decoration: BoxDecoration(
                color: "#744BFC".toColor(),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            bottom: (MediaQuery.of(context).size.width / 4) * 1.05,
            child: Container(
              width: (MediaQuery.of(context).size.width / 4) * 0.95,
              height: (MediaQuery.of(context).size.width / 4) * 1.95,
              decoration: BoxDecoration(
                color: "#744BFC".toColor(),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
            ),
          ),
          //Center
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  "rastmobile-icon".toSvg,
                  color: "#744BFC".toColor(),
                  width: 40.w,
                ),
                1.h.ph,
                Text(
                  "Building the Future",
                  style: TextStyle(
                    color: "#D8D8D8".toColor(),
                    fontWeight: FontWeight.w700,
                    fontSize: 20.sp,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
