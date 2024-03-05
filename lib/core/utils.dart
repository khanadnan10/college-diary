import 'dart:io';

import 'package:college_diary/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: const TextStyle(
            color: Pallete.whiteColor,
          ),
        ),
        backgroundColor: Pallete.blackColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
}

Future<File> pickImagesFromGallery() async {
  File? images;
  final ImagePicker picker = ImagePicker();
  final selectedImages = await picker.pickImage(source: ImageSource.gallery);
  if (selectedImages != null) {
    images = File(selectedImages.path);
  }
  return images!;
}

Future<File> pickImageFromCamera() async {
  File? images;
  final ImagePicker picker = ImagePicker();
  final selectedImages = await picker.pickImage(source: ImageSource.camera);
  if (selectedImages != null) {
    images = File(selectedImages.path);
  }
  return images!;
}
