import 'dart:typed_data';
import 'package:college_diary/core/constants/department_list.dart';
import 'package:college_diary/core/utils.dart';
import 'package:college_diary/core/widgets/custom_text_field_filled.dart';
import 'package:college_diary/core/widgets/loader.dart';
import 'package:college_diary/features/news/controller/news_controller.dart';
import 'package:college_diary/theme/pallete.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
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
  final TextEditingController _linkController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  Uint8List? coverImage;

  void selectCoverImage() async {
    final images = await pickImagesFromGallery(ImageSource.gallery);
    if (images != null) {
      setState(() {
        coverImage = images;
      });
    } else {
      showSnackBar(
        // ignore: use_build_context_synchronously
        context,
        'No image selected 🙈',
        Pallete.blueColor,
      );
    }
  }

  void createNews() {
    if (_key.currentState!.validate() && coverImage != null) {
      ref.read(newsControllerProvider.notifier).createNews(
            context: context,
            title: _titleController.text.trim(),
            content: _contentController.text.trim(),
            department: ref.read(departmenSelectorProvider),
            link: _linkController.text.trim(),
            file: coverImage,
          );
    } else if (_key.currentState!.validate()) {
      ref.read(newsControllerProvider.notifier).createTextNews(
            context: context,
            link: _linkController.text.trim(),
            department: ref.read(departmenSelectorProvider),
            title: _titleController.text.trim(),
            content: _contentController.text.trim(),
          );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _linkController.dispose();
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
                padding: const EdgeInsets.all(16.0).copyWith(bottom: 0),
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
                        height: 20,
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
                        height: 20,
                      ),
                      const Text(
                        'Department',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Pallete.blackColor,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //! DROP DOWN MENU FOR DEPARTMENT
                      InputDecorator(
                        decoration: InputDecoration(
                          filled: true,
                          isDense: true,
                          hintStyle: TextStyle(
                            color: Pallete.greyColor.withOpacity(0.3),
                            fontWeight: FontWeight.w400,
                          ),
                          focusColor: Pallete.greyColor.withOpacity(0.1),
                          fillColor: Pallete.greyColor.withOpacity(0.1),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Pallete.greyColor.withOpacity(0.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(
                              color: Pallete.greyColor.withOpacity(0.1),
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Pallete.greyColor.withOpacity(0.0),
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 5,
                          ),
                        ),
                        child: DropdownButton<String>(
                          value: ref.watch(departmenSelectorProvider),
                          isExpanded: true,
                          underline: const SizedBox(),
                          hint: Text(
                            'Select Department',
                            style: TextStyle(
                              color: Pallete.greyColor.withOpacity(0.5),
                            ),
                          ),
                          onChanged: (newValue) {
                            ref
                                .watch(departmenSelectorProvider.notifier)
                                .update((state) {
                              if (kDebugMode) {
                                print(state);
                              }
                              return newValue!;
                            });
                          },
                          items: departments
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 20.0),

                      const Text(
                        'Links',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Pallete.blackColor,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CTextFieldFilled(
                        controller: _linkController,
                        style: const TextStyle(color: Pallete.blueColor),
                        hintText: 'Have links/forms?',
                        validator: (link) {
                          if (link!.isEmpty) {
                            return null;
                          } else if (!isLinkValid(link.toString())) {
                            return 'The link is broken';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'News',
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
          curve: Curves.fastEaseInToSlowEaseOut,
          height:
              (_titleController.text.isEmpty || _contentController.text.isEmpty)
                  ? 0
                  : kToolbarHeight,
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.only(
            left: 10.0,
            bottom: 10.0,
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
