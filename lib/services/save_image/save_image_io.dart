import 'dart:io';

import 'package:file_saver/file_saver.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

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

  static Future<String?> uploadImageToStorage({
    required XFile file,
    required Reference storageReference,
    void Function(double)? progressCallback,
  }) async {
    // await storageReference.putFile(File(file.path));
    UploadTask task = storageReference.putFile(File(file.path));
    if (progressCallback != null) {
      task.snapshotEvents.listen((event) {
        double progress = event.bytesTransferred / event.totalBytes;
        progressCallback(progress);
      });
    }

    TaskSnapshot snapshot = await task;
    if (snapshot.state == TaskState.success) {
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } else {
      return null;
    }
  }
}
