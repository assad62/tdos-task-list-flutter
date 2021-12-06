import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImageService{

  static final ImageService _singleton = ImageService._internal();
  factory ImageService() {
    return _singleton;
  }
  ImageService._internal();


  Future<File?> compressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path, targetPath,
      quality: 40,

    );



    return result;
  }


}