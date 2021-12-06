import 'package:flutter/material.dart';
import 'package:flutter_starter_app/common/navigation_service.dart';
import 'package:flutter_starter_app/models/TaskListModel.dart';
import 'package:flutter_starter_app/models/TaskModel.dart';
import 'package:flutter_starter_app/services/task_service/task_data_repository.dart';
import 'package:flutter_starter_app/ui/router.dart';

import '../common/base_model.dart';
import '../common/viewstate.dart';
import '../locator.dart';

class HomeModel extends BaseModel{


  late TaskList allTasks;
  List<Task> completedTaskList = [];
  List<Task> pendingTaskList = [];
  var repo = TaskDataRepository();
  void onFirstLoad() async{


    updateTaskCount();
  }

  void addNewTask() async{
    await Navigator.pushNamed(locator<NavigationService>().navigatorKey.currentContext!,AppRoutes.newTaskPageRoute);
    updateTaskCount();
  }

  void updateTaskCount() async {
    setState(ViewState.Busy);
    //get all tasks
    allTasks = await repo.getAllTasks();
    pendingTaskList = allTasks.taskList!.where((e) => e.completed == false).toList();
    completedTaskList = allTasks.taskList!.where((e) => e.completed == true).toList();
    setState(ViewState.Idle);
  }

  bool showEditModal() {

    return true;
  }

  Future<bool> onTaskComplete(String? taskId) {

    // Data task = taskList[taskList.indexWhere((element) => element.taskID == taskId)];
    // task.isCompleted = true;
    // service.updateTask(task);
    //
    // setState(ViewState.Idle);
    // updateTaskCount();
    return Future<bool>.value(true);
  }

  Future<void> deleteTask(String taskId) async {
    await repo.deleteTask(taskId);
    pendingTaskList.removeWhere((e) => e.sId == taskId);
    setState(ViewState.Idle);

  }
}