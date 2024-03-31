import 'dart:typed_data';

import 'package:college_diary/core/providers/storage_provider.dart';
import 'package:college_diary/core/utils.dart';
import 'package:college_diary/features/auth/controller/auth_controller.dart';
import 'package:college_diary/features/post/controller/post_controller.dart';
import 'package:college_diary/features/profile/repository/profile_repository.dart';
import 'package:college_diary/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

final profileControllerProvider =
    StateNotifierProvider<ProfileController, bool>((ref) {
  return ProfileController(
    profileRepository: ref.watch(profileRepositoryProvider),
    ref: ref,
    storageRepository: ref.watch(storageRepositoryProvider),
  );
});

class ProfileController extends StateNotifier<bool> {
  final ProfileRepository _profileRepository;
  final Ref _ref;
  final StorageRepository _storageRepository;

  ProfileController({
    required ProfileRepository profileRepository,
    required Ref ref,
    required StorageRepository storageRepository,
  })  : _profileRepository = profileRepository,
        _ref = ref,
        _storageRepository = storageRepository,
        super(false);

  void updateUser({
    required BuildContext context,
    required String name,
    required Uint8List? file,
  }) async {
    try {
      state = true;
      UserModel user = _ref.read(userProvider)!;
      // Post userPost = _ref.read(postControllerProvider.notifier).
      if (file != null) {
        final res = await _storageRepository.storeFile(
          path: 'profile',
          id: user.uid,
          file: file,
        );
        res.fold(
          (l) => showSnackBar(context, l.message),
          (url) => user = user.copyWith(profilePic: url),
        );
      }
      user = user.copyWith(name: name);
      final updatedUser = await _profileRepository.updateUser(user);

      state = false;

      updatedUser.fold(
        (l) => showSnackBar(context, l.message),
        (r) {
          _ref.read(userProvider.notifier).update((state) => user);
          _ref
              .read(postControllerProvider.notifier)
              .updateUserPost(context: context);
          showSnackBar(context, 'Profile updated successfully.😃');
          Routemaster.of(context).pop();
        },
      );
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }
}
