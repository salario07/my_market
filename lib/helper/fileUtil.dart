import 'dart:io';

import 'package:file_picker/file_picker.dart';

class FileUtil {

  static File getSingleFileFromFilePicker(FilePickerResult result) {
    if (result != null) {
      return File(result.files.single.path);
    } else {
      return null;
    }
  }

  static Future<FilePickerResult> imageFilePicker() async {
    return await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg','jpeg','png'],
    );
  }
}