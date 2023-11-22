// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:rastmobile_task_enes_dorukbasi/core/blocs/todo/todo_bloc.dart';
import 'package:rastmobile_task_enes_dorukbasi/core/controllers/home_page_controller.dart';
import 'package:rastmobile_task_enes_dorukbasi/inits/base_singleton.dart';
import 'package:rastmobile_task_enes_dorukbasi/inits/cache_manager/cache_manager.dart';
import 'package:rastmobile_task_enes_dorukbasi/ui/widgets/card.dart';
import 'package:rastmobile_task_enes_dorukbasi/ui/widgets/row_title.dart';
import 'package:rastmobile_task_enes_dorukbasi/ui_helpers/custom_inputdecorations.dart';
import 'package:rastmobile_task_enes_dorukbasi/ui_helpers/custom_scaffold.dart';
import 'package:rastmobile_task_enes_dorukbasi/utils/enums/route_enums.dart';
import 'package:rastmobile_task_enes_dorukbasi/utils/extensions/num_extensions.dart';
import 'package:rastmobile_task_enes_dorukbasi/utils/extensions/string_extensions.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with BaseSingleton {
  late TodoBloc _todoBloc;
  final HomePageController _controller = Get.put(HomePageController());

  TextEditingController searchTextEditingController = TextEditingController();
  TextEditingController titleTextEditingController = TextEditingController();
  TextEditingController descriptionTextEditingController =
      TextEditingController();
  TextEditingController assigneeTextEditingController = TextEditingController();
  String? status;

  @override
  void initState() {
    super.initState();
    _todoBloc = context.read<TodoBloc>()..add(FetchAllTodos());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoBloc, TodoState>(
      bloc: _todoBloc,
      builder: (context, state) {
        if (state is TodoInitialized) {
          _controller.inputList(
              backlogLst: state.backlogTodos,
              todoLst: state.normalTodos,
              inProgressLst: state.inProgressTodos,
              doneLst: state.doneTodos);
        }
        return Obx(
          () => CustomScaffold(
            searchTextEditingController: searchTextEditingController,
            floatActionButton: (_controller.isAddPopOpened.value == true)
                ? const SizedBox()
                : FloatingActionButton(
                    onPressed: () {
                      _controller.changeAddPopStatus(true);
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
                                        onPressed: () {
                                          _controller.changeAddPopStatus(false);
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(
                                          Icons.close,
                                          size: 8.w,
                                        ),
                                      ),
                                    ),
                                    1.h.ph,
                                    Text(
                                      "To Do",
                                      style: TextStyle(
                                        color: "#000000".toColor(),
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    1.h.ph,
                                    TextField(
                                      controller: titleTextEditingController,
                                      decoration: CustomInputDecorations()
                                          .decoration1(hintText: "Title"),
                                    ),
                                    1.h.ph,
                                    TextField(
                                      controller:
                                          descriptionTextEditingController,
                                      maxLines: 4,
                                      decoration: CustomInputDecorations()
                                          .decoration1(hintText: "Description"),
                                    ),
                                    1.h.ph,
                                    DropdownButtonFormField<String>(
                                      value: _controller
                                                  .selectedStatusInPop.value ==
                                              ""
                                          ? null
                                          : _controller
                                              .selectedStatusInPop.value,
                                      onChanged: (String? newValue) {
                                        _controller.changeSelectedStatusInPop(
                                            newValue!);
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
                                    1.h.ph,
                                    TextField(
                                      controller: assigneeTextEditingController,
                                      decoration: CustomInputDecorations()
                                          .decoration1(hintText: "Assignee"),
                                    ),
                                    3.h.ph,
                                    InkWell(
                                      onTap: () {
                                        if (titleTextEditingController
                                                .text.isNotEmpty &&
                                            descriptionTextEditingController
                                                .text.isNotEmpty &&
                                            _controller.selectedStatusInPop
                                                .value.isNotEmpty &&
                                            assigneeTextEditingController
                                                .text.isNotEmpty) {
                                          _controller.changeAddPopStatus(false);
                                          _todoBloc.add(
                                            GenerateTodo(
                                                title:
                                                    titleTextEditingController
                                                        .text,
                                                description:
                                                    descriptionTextEditingController
                                                        .text,
                                                status: _controller
                                                    .selectedStatusInPop.value,
                                                assignee:
                                                    assigneeTextEditingController
                                                        .text,
                                                context: context,
                                                bloc: _todoBloc),
                                          );
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(3.w),
                      child: Center(
                        child: SvgPicture.asset("plus-icon".toSvg),
                      ),
                    ),
                  ),
            child: (state is TodoInitialized)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      state.cachedTodos.isEmpty
                          ? const SizedBox()
                          : Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    RowTitle(
                                      title: "Clicked",
                                      subTitle:
                                          state.cachedTodos.length.toString(),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await CacheManager.clearAll();
                                        _todoBloc.add(FetchAllTodos());
                                      },
                                      child: const Text("Clean"),
                                    ),
                                  ],
                                ),
                                2.h.ph,
                                SizedBox(
                                  height: 25.h,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: state.cachedTodos.length,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2.w, vertical: 2.h),
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        key: ValueKey(index),
                                        onTap: () async {
                                          context.go(
                                            RouteEnums.details.routeName,
                                            extra: state.cachedTodos[index],
                                          );
                                        },
                                        child: CardWidget(
                                          modelJSON: state.cachedTodos[index],
                                          isCached: true,
                                          index: index,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                      2.h.ph,
                      _controller.backlogList.isEmpty
                          ? const SizedBox()
                          : Column(
                              children: [
                                RowTitle(
                                  title: "Backlog",
                                  subTitle:
                                      _controller.backlogList.length.toString(),
                                ),
                                2.h.ph,
                                SizedBox(
                                  height: 25.h,
                                  child: ReorderableListView.builder(
                                    itemCount: _controller.backlogList.length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2.w, vertical: 2.h),
                                    scrollDirection: Axis.horizontal,
                                    onReorder: (oldIndex, newIndex) =>
                                        _controller.onReorder(
                                            oldIndex, newIndex, "backlog"),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        key: ValueKey(index),
                                        onTap: () async {
                                          await CacheManager.cacheTodoModel(
                                            _controller.backlogList[index],
                                          );
                                          context.go(
                                            RouteEnums.details.routeName,
                                            extra:
                                                _controller.backlogList[index],
                                          );
                                        },
                                        child: CardWidget(
                                          modelJSON: _controller
                                              .backlogList[index]
                                              .toJson(),
                                          isCached: false,
                                          index: index,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                2.h.ph,
                              ],
                            ),
                      _controller.todoList.isEmpty
                          ? const SizedBox()
                          : Column(
                              children: [
                                RowTitle(
                                  title: "To Do",
                                  subTitle:
                                      _controller.todoList.length.toString(),
                                ),
                                2.h.ph,
                                SizedBox(
                                  height: 25.h,
                                  child: ReorderableListView.builder(
                                    itemCount: _controller.todoList.length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2.w, vertical: 2.h),
                                    scrollDirection: Axis.horizontal,
                                    onReorder: (oldIndex, newIndex) =>
                                        _controller.onReorder(
                                            oldIndex, newIndex, "todo"),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        key: ValueKey(index),
                                        onTap: () async {
                                          await CacheManager.cacheTodoModel(
                                            _controller.todoList[index],
                                          );
                                          context.go(
                                            RouteEnums.details.routeName,
                                            extra: _controller.todoList[index],
                                          );
                                        },
                                        child: CardWidget(
                                          modelJSON: _controller.todoList[index]
                                              .toJson(),
                                          isCached: false,
                                          index: index,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                      _controller.inProgressList.isEmpty
                          ? const SizedBox()
                          : Column(
                              children: [
                                RowTitle(
                                  title: "In progress",
                                  subTitle: _controller.inProgressList.length
                                      .toString(),
                                ),
                                2.h.ph,
                                SizedBox(
                                  height: 25.h,
                                  child: ReorderableListView.builder(
                                    itemCount:
                                        _controller.inProgressList.length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2.w, vertical: 2.h),
                                    scrollDirection: Axis.horizontal,
                                    onReorder: (oldIndex, newIndex) =>
                                        _controller.onReorder(
                                            oldIndex, newIndex, "inProgress"),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        key: ValueKey(index),
                                        onTap: () async {
                                          await CacheManager.cacheTodoModel(
                                            _controller.inProgressList[index],
                                          );
                                          context.go(
                                            RouteEnums.details.routeName,
                                            extra: _controller
                                                .inProgressList[index],
                                          );
                                        },
                                        child: CardWidget(
                                          modelJSON: _controller
                                              .inProgressList[index]
                                              .toJson(),
                                          isCached: false,
                                          index: index,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                      _controller.doneList.isEmpty
                          ? const SizedBox()
                          : Column(
                              children: [
                                RowTitle(
                                  title: "Done",
                                  subTitle:
                                      _controller.doneList.length.toString(),
                                ),
                                2.h.ph,
                                SizedBox(
                                  height: 25.h,
                                  child: ReorderableListView.builder(
                                    itemCount: _controller.doneList.length,
                                    shrinkWrap: true,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 2.w, vertical: 2.h),
                                    scrollDirection: Axis.horizontal,
                                    onReorder: (oldIndex, newIndex) =>
                                        _controller.onReorder(
                                            oldIndex, newIndex, "done"),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        key: ValueKey(index),
                                        onTap: () async {
                                          await CacheManager.cacheTodoModel(
                                            _controller.doneList[index],
                                          );
                                          context.go(
                                            RouteEnums.details.routeName,
                                            extra: _controller.doneList[index],
                                          );
                                        },
                                        child: CardWidget(
                                          modelJSON: _controller.doneList[index]
                                              .toJson(),
                                          isCached: false,
                                          index: index,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                    ],
                  )
                : (state is TodoInitialError)
                    ? Column(
                        children: [
                          Center(
                            child: Text(
                              state.errorMessage,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18.sp,
                              ),
                            ),
                          ),
                        ],
                      )
                    : functions.platformIndicator(),
          ),
        );
      },
    );
  }
}
