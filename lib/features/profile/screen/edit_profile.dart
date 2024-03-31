import 'dart:typed_data';

import 'package:college_diary/core/utils.dart';
import 'package:college_diary/core/widgets/custom_text_field_filled.dart';
import 'package:college_diary/core/widgets/loader.dart';
import 'package:college_diary/features/auth/controller/auth_controller.dart';
import 'package:college_diary/features/profile/controller/profile_controller.dart';
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
  late TextEditingController _enrollmentController;

  Uint8List? profileImage;

  @override
  void initState() {
    super.initState();
    _emailController =
        TextEditingController(text: ref.read(userProvider)!.email);
    _nameController = TextEditingController(text: ref.read(userProvider)!.name);
    _phoneNumberController =
        TextEditingController(text: ref.read(userProvider)!.phoneNumber);
    _enrollmentController =
        TextEditingController(text: ref.read(userProvider)!.enrollmentNumber);
  }

  void selectProfileImage() async {
    Uint8List images = await pickImagesFromGallery(ImageSource.gallery);
    setState(() {
      profileImage = images;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    // _passwordController.dispose();
    _nameController.dispose();
    _phoneNumberController.dispose();
    _enrollmentController.dispose();
  }

  void updateProfile() {
    ref.read(profileControllerProvider.notifier).updateUser(
          context: context,
          name: _nameController.text.trim(),
          file: profileImage,
        );
  }

  @override
  Widget build(BuildContext context) {
    final editProfileLoading = ref.watch(profileControllerProvider);
    final user = ref.watch(userProvider)!;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: editProfileLoading
          ? const Loader()
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: profileImage != null
                        ? MemoryImage(
                            profileImage!,
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
                    keyboardType: TextInputType.phone,
                    validator: (phone) {
                      if (phone!.isEmpty || phone.length < 10) {
                        return 'Enter a valid phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CTextFieldFilled(
                    readOnly: true,
                    controller: _enrollmentController,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: updateProfile,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.bounceInOut,
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
                        'Update Profile',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Pallete.whiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
