import 'TaskModel.dart';

class TaskList {
  int? status;
  String? message;
  List<Task>? taskList;

  TaskList({this.status, this.message, this.taskList});

  TaskList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['body'] != null) {
      taskList = <Task>[];
      json['body'].forEach((v) {
        taskList!.add(new Task.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.taskList != null) {
      data['body'] = this.taskList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

