import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../services/display_image/display_image.dart';
import '../services/save_image/save_image.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({super.key});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  Directory? dir;
  List<String> files = [];

  @override
  void initState() {
    getDirs();
    super.initState();
  }

  void getDirs() async {
    if (kIsWeb) {
      setState(() {});
      return;
    }

    dir = await getApplicationDocumentsDirectory();
    files = [];
    dir!.list().listen(
      (file) {
        files.add(file.path);
      },
      onDone: () {
        setState(() {});
      },
    );

    setState(() {});
  }

  void showSnackBar(String text) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Image Example"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (dir != null) Text("Saving to ${dir!.path}"),
            FilledButton(
              style: FilledButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.padded,
              ),
              onPressed: () async {
                _image = await _picker.pickImage(source: ImageSource.camera);
                if (_image != null) {
                  var result = await SaveImage.saveImageToGallery(_image!);
                  showSnackBar(result);
                  setState(() {});
                }
              },
              child: Text("Take Photo"),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                tapTargetSize: MaterialTapTargetSize.padded,
              ),
              onPressed: () async {
                _image = await _picker.pickImage(source: ImageSource.gallery);
                if (_image != null) {
                  var result = await SaveImage.saveImageToGallery(_image!);
                  showSnackBar(result);
                  getDirs();
                }
              },
              child: Text("Pick Image"),
            ),
            if (_image != null)
              SizedBox(height: 300, child: DisplayImage.displayImage(_image!)),
            Text("Images saved to the Application directory"),
            if (files.isNotEmpty)
              Expanded(
                child: ListView(
                  primary: false,
                  children: files
                      .where((file) {
                        return file.endsWith(".jpg");
                      })
                      .toList()
                      .map((file) {
                        return ListTile(
                          title: Text(file),
                          leading: DisplayImage.displayImage(XFile(file)),
                        );
                      })
                      .toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
