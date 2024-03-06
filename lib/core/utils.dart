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

pickImagesFromGallery(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);
  if (file != null) {
    return await file.readAsBytes();
  }
}