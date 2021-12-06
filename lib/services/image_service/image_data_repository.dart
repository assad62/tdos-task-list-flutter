import 'dart:io';

import 'package:flutter_starter_app/repositories/image_repository/image_repo.dart';
import 'package:flutter_starter_app/services/image_service/image_service.dart';

class ImageDataRepository extends IImageRepository{

  var _service = ImageService();
  @override
  Future<File?> compressAndGetFile(File file, String targetPath) async {

    return await _service.compressAndGetFile(file, targetPath);
  }

}