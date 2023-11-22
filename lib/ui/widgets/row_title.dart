import 'package:flutter/material.dart';
import 'package:rastmobile_task_enes_dorukbasi/utils/extensions/num_extensions.dart';
import 'package:rastmobile_task_enes_dorukbasi/utils/extensions/string_extensions.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class RowTitle extends StatefulWidget {
  const RowTitle({super.key, required this.title, required this.subTitle});

  final String title;
  final String subTitle;

  @override
  State<RowTitle> createState() => _RowTitleState();
}

class _RowTitleState extends State<RowTitle> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        1.w.pw,
        Text(
          widget.subTitle,
          style: TextStyle(
            fontSize: 18.sp,
            color: "#D8D8D8".toColor(),
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
