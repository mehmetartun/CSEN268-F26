import 'dart:io';

import 'package:file_saver/file_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class SaveImage {
  static Future<String> saveImageToGallery(XFile file) async {
    Directory directory = await getApplicationDocumentsDirectory();

    String result = await FileSaver.instance.saveFile(
      name: "testFile_${DateTime.now().millisecondsSinceEpoch}.jpg",
      file: File(file.path),
      mimeType: MimeType.jpeg,
    );
    print(result);
    return "Saved to ${directory.path}";
  }
}
