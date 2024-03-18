import 'dart:typed_data';

import 'package:college_diary/core/utils.dart';
import 'package:college_diary/core/widgets/custom_text_field.dart';
import 'package:college_diary/core/widgets/custom_text_field_filled.dart';
import 'package:college_diary/features/auth/controller/auth_controller.dart';
import 'package:college_diary/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class EditProfile extends ConsumerStatefulWidget {
  const EditProfile({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  late TextEditingController _emailController;
  // final TextEditingController _passwordController = TextEditingController();
  late TextEditingController _nameController;
  late TextEditingController _phoneNumberController;
  // final TextEditingController _enrollmentController = TextEditingController();

  Uint8List? coverImage;

  @override
  void initState() {
    super.initState();
    _emailController =
        TextEditingController(text: ref.read(userProvider)!.email);
    _nameController = TextEditingController(text: ref.read(userProvider)!.name);
    _phoneNumberController =
        TextEditingController(text: ref.read(userProvider)!.phoneNumber);
  }

  void selectProfileImage() async {
    Uint8List images = await pickImagesFromGallery(ImageSource.gallery);
    setState(() {
      coverImage = images;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    // _passwordController.dispose();
    _nameController.dispose();
    _phoneNumberController.dispose();
    // _enrollmentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50.0,
              backgroundImage: coverImage != null
                  ? MemoryImage(
                      coverImage!,
                    )
                  : user.profilePic != null
                      ? NetworkImage(user.profilePic!) as ImageProvider
                      : const AssetImage(
                          'assets/images/blank_profile_picture.png',
                        ),
              child: GestureDetector(
                onTap: selectProfileImage,
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Icon(
                    Icons.edit,
                    size: 40.0,
                    color: Pallete.blueColor,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CTextFieldFilled(
              controller: _emailController,
              readOnly: true,
              style: TextStyle(
                color: Pallete.greyColor.withOpacity(0.5),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CTextFieldFilled(
              controller: _nameController,
            ),
            const SizedBox(
              height: 10,
            ),
            CTextFieldFilled(
              controller: _phoneNumberController,
            ),
          ],
        ),
      ),
    );
  }
}
