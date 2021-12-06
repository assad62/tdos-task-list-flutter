import 'package:flutter_starter_app/models/TaskListModel.dart';
import 'package:flutter_starter_app/models/TaskModel.dart';

import 'package:dio/dio.dart';
abstract class ITaskRepository {

  Future<void> insertTask(FormData taskFormData);

  Future<void> deleteTask(String taskId);

  void updateTask(Task newTask);

  Future<TaskList> getAllTasks();
}
