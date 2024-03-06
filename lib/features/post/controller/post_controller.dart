import 'dart:typed_data';
import 'package:college_diary/core/providers/storage_provider.dart';
import 'package:college_diary/features/auth/controller/auth_controller.dart';
import 'package:college_diary/features/post/repository/post_repository.dart';
import 'package:college_diary/model/post_model.dart';
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

  void sharePublicPostWithImage({
    required BuildContext context,
    required String? title,
    required String postType,
    required Uint8List file,
  }) async {
    final user = _ref.read(userProvider)!;
    final postId = const Uuid().v1();

    state = true;
    final res = await _storageRepository.storeFile(
      path: "post/${user.uid}",
      id: postId,
      file: file,
    );
    res.fold(
      (l) => showSnackBar(context, l.message),
      (imageUrl) async {
        Post post = Post(
          pid: postId,
          uid: user.uid,
          likes: [],
          images: imageUrl,
          content: title,
          dislikes: [],
          postType: postType,
          createdAt: DateTime.now(),
        );
        final res = await _postRepository.addPost(post);
        state = false;
        res.fold(
          (l) => showSnackBar(context, l.message),
          (r) {
            showSnackBar(context, 'Posted successfully!');
          },
        );
      },
    );
  }

  void sharePublicTextPost({
    required BuildContext context,
    required String? title,
    required String postType,
  }) async {
    final user = _ref.read(userProvider)!;
    final postId = const Uuid().v1();

    state = true;
    Post post = Post(
      pid: postId,
      uid: user.uid,
      likes: [],
      content: title,
      dislikes: [],
      postType: postType,
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
  }
}
