import 'dart:io';

import 'package:college_diary/core/common/widgets/loader.dart';
import 'package:college_diary/core/enums/post_enum.dart';
import 'package:college_diary/core/utils.dart';
import 'package:college_diary/features/auth/controller/auth_controller.dart';
import 'package:college_diary/features/home/controller/bottom_nav_bar_controller.dart';
import 'package:college_diary/features/post/controller/post_controller.dart';
import 'package:college_diary/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPostScreen extends ConsumerStatefulWidget {
  const AddPostScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends ConsumerState<AddPostScreen> {
  final TextEditingController postController = TextEditingController();

  File? selectedImages;
  void galleryImage() async {
    final images = await pickImagesFromGallery();
    selectedImages = images;
    setState(() {});
  }

  void cameraImage() async {
    final images = await pickImageFromCamera();
    selectedImages = images;
    setState(() {});
  }

  void uploadPost() async {
    if (postController.text.isNotEmpty || selectedImages != null) {
      ref.read(postControllerProvider.notifier).sharePost(
            context: context,
            title: postController.text.trim(),
            postType: selectedImages != null
                ? PostType.image.name.toString()
                : PostType.text.name.toString(),
            club: null,
            file: selectedImages,
          );
    }
    postController.clear();
    selectedImages = null;
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    postController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(postControllerProvider)
        ? const Loader()
        : Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0).copyWith(bottom: 0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Pallete.blueColor,
                      ),
                      onPressed: uploadPost,
                      child: const Text(
                        'Post',
                        style: TextStyle(
                          color: Pallete.whiteColor,
                        ),
                      )),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  padding: const EdgeInsets.all(16.0).copyWith(top: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1,
                              child: CircleAvatar(
                                radius: 26.0,
                                backgroundImage:
                                    ref.read(userProvider)!.profilePic.isEmpty
                                        ? const NetworkImage(
                                            'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                                          )
                                        : NetworkImage(
                                            ref.read(userProvider)!.profilePic),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextField(
                                    controller: postController,
                                    decoration: const InputDecoration(
                                      hintText: 'Enter your thoughts...',
                                      isDense: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    maxLines: null,
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  selectedImages != null
                                      ? SizedBox(
                                          height: 200,
                                          width: 300,
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: FileImage(
                                                  selectedImages!,
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                              color: Pallete.blueColor,
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: IconButton(
                                                  onPressed: () {
                                                    selectedImages!.delete();
                                                  },
                                                  icon:
                                                      const Icon(Icons.cancel),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      Row(
                        children: [
                          IconButton(
                            onPressed: galleryImage, //! Select image here
                            icon: const Icon(
                              size: 30.0,
                              Icons.photo_outlined,
                            ),
                          ),
                          IconButton(
                            onPressed: cameraImage, //! Select image here
                            icon: const Icon(
                              size: 30.0,
                              Icons.camera_alt_outlined,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
  }
}
