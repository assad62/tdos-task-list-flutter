import 'dart:io';


abstract class IImageRepository {

  Future<File?> compressAndGetFile(File file, String targetPath);


}
