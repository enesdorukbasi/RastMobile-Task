// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:go_router/go_router.dart';
import 'package:rastmobile_task_enes_dorukbasi/utils/enums/route_enums.dart';
import 'package:rastmobile_task_enes_dorukbasi/utils/extensions/context_extensions.dart';
import 'package:rastmobile_task_enes_dorukbasi/utils/extensions/string_extensions.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'dart:io' show Platform;

class CustomBottombars {
  bottombar({required BuildContext context}) {
    return Container(
      height: context.heightByDesign(300),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 9.0,
            color: "#00000040".toColor().withOpacity(0.25),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 3.8.h),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              onTap: () => context.go(RouteEnums.home.routeName),
              child: SvgPicture.asset(
                "home-icon".toSvg,
                width: context.widthByDesign(67),
                height: context.widthByDesign(67),
              ),
            ),
            InkWell(
              onTap: () => FlutterWebBrowser.openWebPage(
                url: Platform.isIOS
                    ? "https://apps.apple.com/us/app/word-ninja-social-word-game/id1571204627"
                    : "https://getwordninja.com/getwordgame.php",
                customTabsOptions: const CustomTabsOptions(
                  colorScheme: CustomTabsColorScheme.dark,
                  toolbarColor: Colors.deepPurple,
                  secondaryToolbarColor: Colors.white,
                  shareState: CustomTabsShareState.on,
                  instantAppsEnabled: true,
                  showTitle: true,
                  urlBarHidingEnabled: true,
                ),
                safariVCOptions: const SafariViewControllerOptions(
                  barCollapsingEnabled: true,
                  preferredBarTintColor: Colors.deepPurple,
                  preferredControlTintColor: Colors.white,
                  dismissButtonStyle:
                      SafariViewControllerDismissButtonStyle.close,
                  modalPresentationCapturesStatusBarAppearance: true,
                ),
              ),
              child: Text(
                "Go to Word Ninja",
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w400,
                  color: "#000000".toColor(),
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
