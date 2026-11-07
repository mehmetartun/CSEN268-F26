import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class SaveImage {
  static Future<String> saveImageToGallery(XFile file) async {
    var bytes = await file.readAsBytes();
    await FileSaver.instance.saveFile(
      name: "Hello",
      bytes: bytes,
      fileExtension: "jpg",
      mimeType: MimeType.jpeg,
    );
    return "OK";
  }

  static Future<String?> uploadImageToStorage({
    required XFile file,
    required Reference storageReference,
    void Function(double)? progressCallback,
  }) async {
    Uint8List fileBytes = await file.readAsBytes();
    SettableMetadata metadata = SettableMetadata(
      contentType: file.mimeType, // e.g., 'image/jpeg', 'application/pdf'
    );
    UploadTask uploadTask = storageReference.putData(fileBytes, metadata);
    TaskSnapshot snapshot = await uploadTask;
    if (progressCallback != null) {
      uploadTask.snapshotEvents.listen((event) {
        progressCallback(event.bytesTransferred / event.totalBytes);
      });
    }
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
