import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:rastmobile_task_enes_dorukbasi/core/blocs/todo/todo_bloc.dart';
import 'package:rastmobile_task_enes_dorukbasi/core/controllers/home_page_controller.dart';
import 'package:rastmobile_task_enes_dorukbasi/core/models/todo_model.dart';
import 'package:rastmobile_task_enes_dorukbasi/inits/base_singleton.dart';
import 'package:rastmobile_task_enes_dorukbasi/ui/widgets/card.dart';
import 'package:rastmobile_task_enes_dorukbasi/ui_helpers/custom_bottombars.dart';
import 'package:rastmobile_task_enes_dorukbasi/ui_helpers/custom_inputdecorations.dart';
import 'package:rastmobile_task_enes_dorukbasi/utils/enums/route_enums.dart';
import 'package:rastmobile_task_enes_dorukbasi/utils/extensions/num_extensions.dart';
import 'package:rastmobile_task_enes_dorukbasi/utils/extensions/string_extensions.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomScaffold extends StatefulWidget {
  const CustomScaffold(
      {super.key,
      required this.child,
      this.floatActionButton,
      required this.searchTextEditingController});

  final Widget? floatActionButton;
  final TextEditingController searchTextEditingController;
  final Widget child;

  @override
  State<CustomScaffold> createState() => _CustomScaffoldState();
}

class _CustomScaffoldState extends State<CustomScaffold> with BaseSingleton {
  late TodoBloc _bloc;
  final HomePageController _controller = HomePageController();

  @override
  void initState() {
    super.initState();
    _bloc = context.read<TodoBloc>()..add(FetchAllTodos());
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        floatingActionButton: widget.floatActionButton,
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.width * 0.2,
          backgroundColor: "#744BFC".toColor(),
          elevation: 0,
          title: Padding(
            padding: EdgeInsets.only(left: 3.w),
            child: AnimatedSwitcher(
              duration: const Duration(seconds: 2),
              child: _controller.isSearchActive.value
                  ? TextField(
                      controller: widget.searchTextEditingController,
                      onChanged: (value) {
                        if (value != "") {
                          _controller.changeSearchTextStatus(true);
                        } else {
                          _controller.changeSearchTextStatus(false);
                        }
                      },
                      decoration: CustomInputDecorations()
                          .decoration1(hintText: "Search"),
                    )
                  : SvgPicture.asset(
                      "rastmobile-icon".toSvg,
                      height: 4.5.h,
                    ),
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                widget.searchTextEditingController.clear();
                _controller.changeSearchTextStatus(false);
                _controller.changeSearchBarStatus();
              },
              borderRadius: BorderRadius.circular(100),
              child: AnimatedSwitcher(
                duration: const Duration(seconds: 2),
                child: _controller.isSearchActive.value
                    ? Icon(
                        Icons.close,
                        size: 3.h,
                        color: Colors.white,
                      )
                    : SvgPicture.asset(
                        "search-icon".toSvg,
                        width: 3.h,
                        height: 3.h,
                      ),
              ),
            ),
            8.w.pw,
            SvgPicture.asset("settings-icon".toSvg, width: 3.h, height: 3.h),
            8.w.pw,
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 3.w, top: 2.h, bottom: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 12.w,
                    height: 12.w,
                    decoration: BoxDecoration(
                      color: "#DFD5FF".toColor(),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Image.asset("ww-logo".toPng),
                    ),
                  ),
                  2.w.pw,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Refactoring for Word Ninja",
                        style: TextStyle(
                          color: "#000000".toColor(),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "New project for refactoring our app Word ninja",
                        style: TextStyle(
                          color: "#000000".toColor(),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              2.h.ph,
              (_controller.searchTextChangeStatus.value)
                  ? BlocBuilder<TodoBloc, TodoState>(
                      bloc: _bloc,
                      builder: (context, state) {
                        if (state is TodoInitialized) {
                          List<ToDoModel> todos = state.todos
                              .where(
                                (element) =>
                                    element.title.toLowerCase().contains(
                                          widget
                                              .searchTextEditingController.text
                                              .toLowerCase(),
                                        ),
                              )
                              .toList();
                          return SizedBox(
                            height: 64.h,
                            child: ListView.builder(
                              itemCount: todos.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 1.h),
                                  child: InkWell(
                                    onTap: () async {
                                      context.go(
                                        RouteEnums.details.routeName,
                                        extra: todos[index],
                                      );
                                    },
                                    child: CardWidget(
                                      modelJSON: todos[index].toJson(),
                                      isCached: false,
                                      index: index,
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        } else if (state is TodoInitialError) {
                          return Center(
                            child: Text(state.errorMessage),
                          );
                        } else {
                          return functions.platformIndicator();
                        }
                      },
                    )
                  : widget.child,
            ],
          ),
        ),
        bottomNavigationBar: CustomBottombars().bottombar(context: context),
      ),
    );
  }
}
