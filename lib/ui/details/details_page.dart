// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:rastmobile_task_enes_dorukbasi/core/controllers/home_page_controller.dart';
import 'package:rastmobile_task_enes_dorukbasi/core/models/todo_model.dart';
import 'package:rastmobile_task_enes_dorukbasi/core/services/todo_services/todo_service.dart';
import 'package:rastmobile_task_enes_dorukbasi/ui/widgets/user_circle_container.dart';
import 'package:rastmobile_task_enes_dorukbasi/ui_helpers/custom_inputdecorations.dart';
import 'package:rastmobile_task_enes_dorukbasi/ui_helpers/custom_scaffold.dart';
import 'package:rastmobile_task_enes_dorukbasi/utils/enums/route_enums.dart';
import 'package:rastmobile_task_enes_dorukbasi/utils/extensions/num_extensions.dart';
import 'package:rastmobile_task_enes_dorukbasi/utils/extensions/string_extensions.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, required this.model});

  final ToDoModel model;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final HomePageController _controller = Get.put(HomePageController());
  TextEditingController searchTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      searchTextEditingController: searchTextEditingController,
      child: Padding(
        padding: EdgeInsets.only(right: 3.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            2.h.ph,
            Text(
              widget.model.title,
              style: TextStyle(
                fontSize: 19.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            2.h.ph,
            Row(
              children: [
                const UserCircleContainer(
                  url:
                      "https://cdn.pixabay.com/photo/2023/11/04/04/45/woman-8364265_1280.jpg",
                ),
                2.w.pw,
                RichText(
                  text: TextSpan(
                    text: "Reported by ",
                    style: TextStyle(
                      color: "#A5A5A5".toColor(),
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      TextSpan(
                        text: widget.model.assignee,
                        style: TextStyle(
                          color: "#0D0D0D".toColor(),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            2.h.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return Dialog(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 3.w),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  1.h.ph,
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: IconButton(
                                      onPressed: () => Navigator.pop(context),
                                      icon: const Icon(Icons.close),
                                    ),
                                  ),
                                  1.h.ph,
                                  DropdownButtonFormField<String>(
                                    value: _controller
                                                .selectedStatusInPop.value ==
                                            ""
                                        ? null
                                        : _controller.selectedStatusInPop.value,
                                    onChanged: (String? newValue) {
                                      _controller
                                          .changeSelectedStatusInPop(newValue!);
                                    },
                                    items: [
                                      "Backlog",
                                      "To Do",
                                      "In Progress",
                                      "Done",
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    decoration: CustomInputDecorations()
                                        .decoration1(hintText: "Status"),
                                  ),
                                  3.h.ph,
                                  InkWell(
                                    onTap: () async {
                                      if (_controller.selectedStatusInPop.value
                                          .isNotEmpty) {
                                        _controller.changeAddPopStatus(false);
                                        await ToDoService().update(
                                            id: widget.model.id.toString(),
                                            title: widget.model.title,
                                            description:
                                                widget.model.description,
                                            status: _controller
                                                .selectedStatusInPop.value,
                                            assignee: widget.model.assignee,
                                            date: widget.model.date);
                                        context.go(RouteEnums.home.routeName);
                                      } else {
                                        Get.snackbar(
                                          "Warning!",
                                          "Fill in all fields.",
                                        );
                                      }
                                    },
                                    child: Center(
                                      child: Container(
                                        width: 50.w,
                                        height: 7.h,
                                        decoration: BoxDecoration(
                                          color: "#744BFC".toColor(),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Save",
                                            style: TextStyle(
                                              color: "#FFFFFF".toColor(),
                                              fontSize: 17.sp,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  3.h.ph,
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    width: 22.w,
                    height: 4.5.h,
                    decoration: BoxDecoration(
                      color: "#744BFC".toColor(),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Center(
                      child: Text(
                        widget.model.status,
                        style: TextStyle(
                          color: "#FFFFFF".toColor(),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  widget.model.date,
                  style: TextStyle(
                    color: "#A5A5A5".toColor(),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            2.h.ph,
            Text(
              "Description",
              style: TextStyle(
                color: "#A5A5A5".toColor(),
                fontWeight: FontWeight.w500,
              ),
            ),
            2.h.ph,
            Container(
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
              decoration: BoxDecoration(
                color: "#F2F2F2".toColor(),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                widget.model.description,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            2.h.ph,
            Row(
              children: [
                "https://cdn.pixabay.com/photo/2023/11/04/04/45/woman-8364265_1280.jpg",
                "https://cdn.pixabay.com/photo/2023/11/04/04/45/woman-8364265_1280.jpg"
              ].map((e) => UserCircleContainer(url: e)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
