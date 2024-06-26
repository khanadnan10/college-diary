import 'dart:typed_data';

import 'package:college_diary/core/constants/abusive_filtration.dart';
import 'package:college_diary/core/widgets/loader.dart';
import 'package:college_diary/core/enums/post_enum.dart';
import 'package:college_diary/core/utils.dart';
import 'package:college_diary/features/auth/controller/auth_controller.dart';
import 'package:college_diary/features/post/controller/post_controller.dart';
import 'package:college_diary/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class AddPostScreen extends ConsumerStatefulWidget {
  const AddPostScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends ConsumerState<AddPostScreen> {
  final TextEditingController postController = TextEditingController();

  Uint8List? selectedImages;
  void galleryImage() async {
    Uint8List images = await pickImagesFromGallery(ImageSource.gallery);
    setState(() {
      selectedImages = images;
    });
  }

  void cameraImage() async {
    Uint8List images = await pickImagesFromGallery(ImageSource.camera);
    setState(() {
      selectedImages = images;
    });
  }

  void uploadPublicTextPost() async {
    if (checkForAbusiveWord(postController.text.trim())) {
      if (postController.text.isNotEmpty) {
        ref.read(postControllerProvider.notifier).sharePublicTextPost(
              context: context,
              title: postController.text.trim(),
              postType: PostType.text.name.toString(),
            );
      }
      postController.clear();
    } else {
      showSnackBar(context, "🙏 Please keep the environment clean.");
    }
  }

  void uploadPublicPostWithImage() async {
    if (checkForAbusiveWord(postController.text.trim())) {
      if (postController.text.isNotEmpty || selectedImages != null) {
        ref.read(postControllerProvider.notifier).sharePublicPostWithImage(
              context: context,
              title: postController.text.trim(),
              postType: PostType.image.name.toString(),
              file: selectedImages!,
            );
      } else {
        showSnackBar(context, "🙏 Please keep the environment clean.");
      }
    }
    postController.clear();
    selectedImages = null;
  }

  void removePickedImage() => setState(() {
        selectedImages = null;
      });

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
    final userProfile = ref.watch(userProvider)!;
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
                      onPressed: userProfile.isBanned
                          ? null
                          : selectedImages != null
                              ? uploadPublicPostWithImage
                              : uploadPublicTextPost,
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
                              child: userProfile.profilePic != null
                                  ? CircleAvatar(
                                      radius: 26.0,
                                      backgroundImage: NetworkImage(
                                          ref.read(userProvider)!.profilePic!),
                                    )
                                  : const CircleAvatar(
                                      radius: 26.0,
                                      backgroundImage: AssetImage(
                                        'assets/images/blank_profile_picture.png',
                                      ),
                                    ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: TextField(
                                      controller: postController,
                                      decoration: const InputDecoration(
                                        hintText: 'Share your thoughts...',
                                        isDense: true,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                      maxLines: null,
                                    ),
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
                                                image: MemoryImage(
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
                                                  onPressed: removePickedImage,
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
