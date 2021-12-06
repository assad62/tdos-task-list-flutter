import 'dart:io';
import 'package:flutter_starter_app/common/viewstate.dart';
import 'package:flutter_starter_app/services/image_service/image_data_repository.dart';
import 'package:flutter_starter_app/services/location_service/location_data_repository.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_starter_app/common/base_model.dart';

import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_starter_app/services/task_service/task_data_repository.dart';

class NewTaskModel extends BaseModel{
  var repo = TaskDataRepository();
  var imageRepo = ImageDataRepository();
  var locationRepo = LocationDataRepository();



  void onFirstLoad(){

  }





  Future<void> addToTaskList(Map<String, dynamic> value) async{

    setState(ViewState.Busy);

    String imagePath = value["photos"][0].path;
    File cacheFile = File(imagePath);
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;



    String fileName = cacheFile.path.split('/').last;

    File? newImage = await imageRepo.compressAndGetFile(cacheFile, '$appDocPath/$fileName');

    String filePath = newImage!.path;
    print("filePath is $filePath");
    Position position = await locationRepo.getPosition();

    FormData newTask = FormData.fromMap({
      "completeBy": getFormattedDateTime(),
      "lat": position.latitude,
      "lng":  position.longitude,
      "file":  await MultipartFile.fromFile(filePath, filename: fileName ),
      "title":value["title"] == null ? "title" : value["title"],
      "description":value["Description"],
      "completed":false,

    });

    print("newTask is $newTask");
    await repo.insertTask(newTask);

    setState(ViewState.Idle);
  }

  String getFormattedDateTime() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-ddTkk:mm:ss').format(now);

    return formattedDate;
  }

}