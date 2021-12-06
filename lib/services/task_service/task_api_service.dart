import 'package:flutter_starter_app/api/api_service.dart';
import 'package:flutter_starter_app/api/endpoints.dart';

import 'package:dio/dio.dart';
import 'package:flutter_starter_app/models/TaskListModel.dart';
class TaskAPIService {

  static final TaskAPIService _singleton = TaskAPIService._internal();
  factory TaskAPIService() {
    return _singleton;
  }
  TaskAPIService._internal();

  Future<TaskList> getListOfAllTasks() async{
    var res = await APIService().getEndpointData(endpoint: Endpoint.listTasks);
    return TaskList.fromJson(res.data);

  }


  Future<void> insertTask(FormData taskFormData) async{

      await APIService().postFormData(endpoint: Endpoint.createTask, formData: taskFormData);


  }


  void deleteTask(String param) async{
    await APIService().deleteEndpointData(endpoint: Endpoint.deleteTask, param: param);
  }




}