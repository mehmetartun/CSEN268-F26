import 'dart:io';

import 'package:material_ui/material_ui.dart';
import 'package:image_picker/image_picker.dart';

class DisplayImage {
  static Widget displayImage(XFile file) {
    return Image.file(File(file.path));
  }
}
