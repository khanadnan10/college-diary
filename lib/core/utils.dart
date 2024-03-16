import 'package:college_diary/features/post/controller/post_controller.dart';
import 'package:college_diary/model/post_model.dart';
import 'package:college_diary/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:routemaster/routemaster.dart';

void showCustomDeleteBottomSheet(BuildContext context, WidgetRef ref, Post pid,
    {String description = "Are you sure you want to delete this post?", Color color= const Color(0xff3370E5),}) {
  showModalBottomSheet(
    context: context,
    showDragHandle: true,
    backgroundColor: color,
    builder: (BuildContext context) {
      return Container(
        color: color,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Delete Post",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Pallete.whiteColor,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  color: Pallete.whiteColor.withOpacity(0.5),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        ref
                            .watch(postControllerProvider.notifier)
                            .deletePost(context, pid);

                        Routemaster.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1,
                            color: Pallete.whiteColor,
                          ),
                          borderRadius: BorderRadius.circular(
                            50.0,
                          ),
                        ),
                      ),
                      child: const Text(
                        'Delete',
                        style: TextStyle(
                          color: Pallete.whiteColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Routemaster.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                            width: 1,
                            color: Pallete.whiteColor,
                          ),
                          borderRadius: BorderRadius.circular(
                            50.0,
                          ),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Pallete.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

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
