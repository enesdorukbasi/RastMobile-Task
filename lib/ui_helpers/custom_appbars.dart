import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rastmobile_task_enes_dorukbasi/utils/extensions/num_extensions.dart';
import 'package:rastmobile_task_enes_dorukbasi/utils/extensions/string_extensions.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomAppbars {
  purpleAppbar(
      {required BuildContext context,
      required TextEditingController searchTextEditingController}) {
    bool isOpenedSearch = false;
    return AppBar(
      toolbarHeight: MediaQuery.of(context).size.width * 0.2,
      backgroundColor: "#744BFC".toColor(),
      elevation: 0,
      title: Padding(
        padding: EdgeInsets.only(left: 3.w),
        child: AnimatedSwitcher(
          duration: const Duration(seconds: 2),
          child: isOpenedSearch
              ? TextField()
              : SvgPicture.asset(
                  "rastmobile-icon".toSvg,
                  height: 4.5.h,
                ),
        ),
      ),
      actions: [
        InkWell(
            onTap: () {},
            child:
                SvgPicture.asset("search-icon".toSvg, width: 3.h, height: 3.h)),
        8.w.pw,
        SvgPicture.asset("settings-icon".toSvg, width: 3.h, height: 3.h),
        8.w.pw,
      ],
    );
  }
}
