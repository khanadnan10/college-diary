import 'package:college_diary/theme/pallete.dart';
import 'package:flutter/material.dart';

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
