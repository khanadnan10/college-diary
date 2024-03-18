import 'dart:typed_data';

import 'package:college_diary/core/utils.dart';
import 'package:college_diary/core/widgets/custom_text_field_filled.dart';
import 'package:college_diary/core/widgets/loader.dart';
import 'package:college_diary/features/news/controller/news_controller.dart';
import 'package:college_diary/theme/pallete.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class CreateNews extends ConsumerStatefulWidget {
  const CreateNews({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateNewsState();
}

class _CreateNewsState extends ConsumerState<CreateNews> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  Uint8List? coverImage;

  void selectCoverImage() async {
    Uint8List images = await pickImagesFromGallery(ImageSource.gallery);
    setState(() {
      coverImage = images;
    });
  }

  void createNews() {
    if (_key.currentState!.validate() && coverImage != null) {
      ref.read(newsControllerProvider.notifier).createNews(
            context: context,
            title: _titleController.text.trim(),
            content: _contentController.text.trim(),
            file: coverImage,
          );
    } else if (_key.currentState!.validate()) {
      ref.read(newsControllerProvider.notifier).createTextNews(
            context: context,
            title: _titleController.text.trim(),
            content: _contentController.text.trim(),
          );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create News',
        ),
      ),
      body: ref.watch(newsControllerProvider)
          ? const Loader()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap:
                            selectCoverImage, //* Selecting cover image for the news
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          radius: const Radius.circular(12.0),
                          dashPattern: const [15, 15, 10, 15],
                          color: Pallete.greyColor.withOpacity(0.5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: SizedBox(
                              height: 170,
                              width: MediaQuery.of(context).size.width,
                              child: coverImage != null
                                  ? Image(
                                      image: MemoryImage(coverImage!),
                                      fit: BoxFit.cover,
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.photo_outlined,
                                          color: Pallete.greyColor
                                              .withOpacity(0.8),
                                        ),
                                        Text(
                                          'Add Cover',
                                          style: TextStyle(
                                            color: Pallete.greyColor
                                                .withOpacity(0.8),
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Title',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Pallete.blackColor,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CTextFieldFilled(
                        controller: _titleController,
                        hintText: 'Title',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Write',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Pallete.blackColor,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CTextFieldFilled(
                        controller: _contentController,
                        hintText: 'Write something here...',
                        maxLine: 15,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
      bottomNavigationBar: GestureDetector(
        onTap: ref.watch(newsControllerProvider) ? null : createNews,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.bounceInOut,
          height:
              (_titleController.text.isEmpty || _contentController.text.isEmpty)
                  ? 0
                  : kToolbarHeight,
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.only(
            bottom: 12.0,
            left: 10.0,
            right: 10.0,
          ),
          decoration: BoxDecoration(
            color: Pallete.blueColor,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: const Text(
            'Publish',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Pallete.whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
