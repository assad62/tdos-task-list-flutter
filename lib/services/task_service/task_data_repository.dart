import 'package:flutter_starter_app/models/TaskListModel.dart';
import 'package:flutter_starter_app/models/TaskModel.dart';
import 'package:flutter_starter_app/repositories/task_repository/task_repo.dart';
import 'package:flutter_starter_app/services/task_service/task_api_service.dart';

import 'package:dio/dio.dart';
class TaskDataRepository extends ITaskRepository{

  var _service = TaskAPIService();

  static final TaskDataRepository _singleton = TaskDataRepository._internal();
  factory TaskDataRepository() {
    return _singleton;
  }
  TaskDataRepository._internal();

  @override
  Future<void> deleteTask(String taskId) async{

    String param = "?id=$taskId";
    _service.deleteTask(param);
  }

  @override
  Future<TaskList> getAllTasks() async {
     TaskList  taskList = await _service.getListOfAllTasks();
     return taskList;

  }

  @override
  Future<void> insertTask(FormData taskFormData) async{
      await _service.insertTask(taskFormData);
  }

  @override
  void updateTask(Task newTask) {
    // TODO: implement updateTask
  }
 
}