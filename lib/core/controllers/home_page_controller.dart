import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:rastmobile_task_enes_dorukbasi/core/models/todo_model.dart';

class HomePageController extends GetxController {
  var isAddPopOpened = false.obs;
  var isSearchActive = false.obs;
  var searchTextChangeStatus = false.obs;
  var selectedStatusInPop = "".obs;
  RxList<ToDoModel> backlogList = <ToDoModel>[].obs;
  RxList<ToDoModel> todoList = <ToDoModel>[].obs;
  RxList<ToDoModel> inProgressList = <ToDoModel>[].obs;
  RxList<ToDoModel> doneList = <ToDoModel>[].obs;

  void onReorder(int oldIndex, int newIndex, String lstName) {
    try {
      if (lstName == "backlog") {
        if (newIndex == backlogList.length) newIndex = backlogList.length - 1;
        ToDoModel val = backlogList.removeAt(oldIndex);
        backlogList.insert(newIndex, val);
      } else if (lstName == "todo") {
        if (newIndex == todoList.length) newIndex = todoList.length - 1;
        ToDoModel val = todoList.removeAt(oldIndex);
        todoList.insert(newIndex, val);
      } else if (lstName == "inProgress") {
        if (newIndex == inProgressList.length) {
          newIndex = inProgressList.length - 1;
        }
        ToDoModel val = inProgressList.removeAt(oldIndex);
        inProgressList.insert(newIndex, val);
      } else if (lstName == "done") {
        if (newIndex == doneList.length) newIndex = doneList.length - 1;
        ToDoModel val = doneList.removeAt(oldIndex);
        doneList.insert(newIndex, val);
      }
    } catch (ex) {
      if (kDebugMode) {
        print("Yerleştirme sorunu : $ex");
      }
    }
  }

  inputList({
    required List<ToDoModel> backlogLst,
    required List<ToDoModel> todoLst,
    required List<ToDoModel> inProgressLst,
    required List<ToDoModel> doneLst,
  }) {
    backlogList = backlogLst.obs;
    todoList = todoLst.obs;
    inProgressList = inProgressLst.obs;
    doneList = doneLst.obs;
  }

  void changeAddPopStatus(bool status) {
    isAddPopOpened.value = status;
  }

  void changeSearchBarStatus() {
    isSearchActive.value = !isSearchActive.value;
  }

  void changeSearchTextStatus(bool value) {
    searchTextChangeStatus.value = value;
  }

  void changeSelectedStatusInPop(String status) {
    selectedStatusInPop.value = status;
  }
}
