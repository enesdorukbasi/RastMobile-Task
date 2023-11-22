import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rastmobile_task_enes_dorukbasi/core/models/todo_model.dart';
import 'package:rastmobile_task_enes_dorukbasi/ui/widgets/user_circle_container.dart';
import 'package:rastmobile_task_enes_dorukbasi/utils/extensions/num_extensions.dart';
import 'package:rastmobile_task_enes_dorukbasi/utils/extensions/string_extensions.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CardWidget extends StatefulWidget {
  const CardWidget(
      {super.key,
      required this.modelJSON,
      required this.isCached,
      required this.index});

  final String modelJSON;
  final bool isCached;
  final int index;

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    ToDoModel model = ToDoModel.fromJson(widget.modelJSON);
    return Padding(
      padding: EdgeInsets.only(right: 5.w),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 21.h,
        decoration: BoxDecoration(
          color: "#FFFFFF".toColor(),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: "#0000001A".toColor().withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.title,
                style: TextStyle(
                  color: "#000000".toColor(),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              1.h.ph,
              Text(
                model.description,
                maxLines: 3,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: "#000000".toColor(),
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              1.h.ph,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      "https://cdn.pixabay.com/photo/2023/11/04/04/45/woman-8364265_1280.jpg",
                      "https://cdn.pixabay.com/photo/2023/11/04/04/45/woman-8364265_1280.jpg"
                    ].map((e) => UserCircleContainer(url: e)).toList(),
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        "calendar-icon".toSvg,
                        // ignore: deprecated_member_use
                        color: "#9F9F9F".toColor(),
                        width: 6.w,
                        height: 6.w,
                      ),
                      1.w.pw,
                      Text(
                        model.date,
                        style: TextStyle(
                          color: "#9F9F9F".toColor(),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
