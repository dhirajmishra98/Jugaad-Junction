import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      margin: const EdgeInsets.all(20),
      showCloseIcon: true,
    ),
  );
}

Future<File?> pickImageFromGallery(BuildContext context) async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    showSnackBar(context, e.toString());
  }
  return image!;
}

Future<List<File>> pickFiles(BuildContext context) async {
  List<File> files = [];
  try {
    final pickedFiles = await ImagePicker().pickMultiImage(
      imageQuality: 20,
    );
    if (pickedFiles.isNotEmpty) {
      for (int i = 0; i < pickedFiles.length; i++) {
        files.add(File(pickedFiles[i].path));
      }
    }
  } catch (e) {
    showSnackBar(context, "from utils file of pickfiles func $e");
  }
  return files;
}
