import 'dart:io';

import 'package:college_diary/core/enums/post_enum.dart';
import 'package:college_diary/core/providers/storage_provider.dart';
import 'package:college_diary/features/auth/controller/auth_controller.dart';
import 'package:college_diary/features/post/repository/post_repository.dart';
import 'package:college_diary/model/club_model.dart';
import 'package:college_diary/model/post_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../core/utils.dart';

final postControllerProvider =
    StateNotifierProvider<PostController, bool>((ref) {
  final postRepository = ref.watch(postRepositoryProvider);
  final storageRepository = ref.watch(storageRepositoryProvider);
  return PostController(
    postRepository: postRepository,
    storageRepository: storageRepository,
    ref: ref,
  );
});

class PostController extends StateNotifier<bool> {
  final PostRepository _postRepository;
  final Ref _ref;
  final StorageRepository _storageRepository;

  PostController({
    required PostRepository postRepository,
    required Ref ref,
    required StorageRepository storageRepository,
  })  : _postRepository = postRepository,
        _ref = ref,
        _storageRepository = storageRepository,
        super(false);

  void sharePost({
    required BuildContext context,
    required String title,
    required String postType,
    required Club? club,
    required File? file,
  }) async {
    final user = _ref.read(userProvider)!;
    final postId = const Uuid().v1();

    try {
      state = true;
      // upload to storage

      //! For club ---------------------------------------------------------------
      if (club != null) {
        if (file != null) {
          final imageRes = await _storageRepository.storeFile(
            path: "posts/clubs/${club.name}",
            id: postId,
            file: file,
          );

          imageRes.fold((l) => showSnackBar(context, l.message), (r) async {
            Post post = Post(
              content: title,
              images: r,
              pid: postId,
              uid: user.uid,
              likes: [],
              dislikes: [],
              postType: postType,
              createdAt: DateTime.now(),
            );
            final res = await _postRepository.addPost(post);
            state = false;
            return res.fold((l) => showSnackBar(context, l.message), (r) {
              showSnackBar(context, 'Posted successfully!');
            });
          });
        }
      }

      //! For Public post -------------------------------------------------------

      if (file != null) {
        await _storageRepository
            .storeFile(
              path: "post/${user.uid}",
              id: postId,
              file: file,
            )
            .then(
              (imageRes) => imageRes.fold(
                (l) => showSnackBar(context, l.message),
                (imageUrl) async {
                  Post post = Post(
                    content: title,
                    images: imageUrl,
                    pid: postId,
                    uid: user.uid,
                    likes: [],
                    dislikes: [],
                    postType: postType.toString(),
                    createdAt: DateTime.now(),
                  );
                  final res = await _postRepository.addPost(post);
                  state = false;
                  return res.fold(
                    (l) => showSnackBar(context, l.message),
                    (r) {
                      showSnackBar(context, 'Posted successfully!');
                    },
                  );
                },
              ),
            );
      }
      Post post = Post(
        content: title,
        images: null,
        pid: postId,
        uid: user.uid,
        likes: [],
        dislikes: [],
        postType: postType.toString(),
        createdAt: DateTime.now(),
      );
      final res = await _postRepository.addPost(post);
      state = false;
      return res.fold((l) => showSnackBar(context, l.message), (r) {
        showSnackBar(context, 'Posted successfully!');
      });
    } catch (e) {
      if (context.mounted) showSnackBar(context, e.toString());
    }
  }
}
