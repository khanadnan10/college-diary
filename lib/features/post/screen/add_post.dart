import 'dart:io';

import 'package:college_diary/core/utils.dart';
import 'package:college_diary/theme/pallete.dart';
import 'package:dotlottie_loader/dotlottie_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class AddPostScreen extends ConsumerStatefulWidget {
  const AddPostScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends ConsumerState<AddPostScreen> {
  final TextEditingController postController = TextEditingController();

  List<File?> selectedImages = [];
  void galleryImage() async {
    final images = await pickImagesFromGallery();
    selectedImages = images;
    setState(() {});
  }

  void cameraImage() async {
    final images = await pickImageFromCamera();
    selectedImages.add(images);
    setState(() {});
  }

  void addPostBottomModelSheet(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: false,
      context: context,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.9,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Pallete.blueColor,
                      ),
                      onPressed: () {
                        //TODO: Post karne ka option yaha se aayega
                      },
                      child: const Text(
                        'Post',
                        style: TextStyle(
                          color: Pallete.whiteColor,
                        ),
                      )),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Expanded(
                        flex: 1,
                        child: CircleAvatar(
                          radius: 26.0,
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
                            selectedImages.isEmpty
                                ? const SizedBox()
                                : SizedBox(
                                    height: 200,
                                    width: 300,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: selectedImages.length,
                                      itemBuilder: (context, index) =>
                                          Container(
                                        padding:
                                            const EdgeInsets.only(right: 10.0),
                                        height: 200,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.7,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: FileImage(
                                              selectedImages[index]!,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                          color: Pallete.blueColor,
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: IconButton(
                                              onPressed: () {
                                                selectedImages.removeAt(index);
                                              },
                                              icon: const Icon(Icons.cancel),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
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
        );
      },
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      addPostBottomModelSheet(context);
    });
    super.initState();
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
    return GestureDetector(
      onVerticalDragStart: (details) => addPostBottomModelSheet(context),
      onTap: () => addPostBottomModelSheet(context),
      child: Scaffold(
        body: Center(
          child: DotLottieLoader.fromAsset(
              'assets/images/Animation - 1709585898350.lottie',
              frameBuilder: (ctx, dotlottie) {
            if (dotlottie != null) {
              return Lottie.memory(dotlottie.animations.values.single,
                  imageProviderFactory: (asset) {
                return MemoryImage(dotlottie.images[asset.fileName]!);
              });
            } else {
              return Container();
            }
          }),
        ),
      ),
    );
  }
}
