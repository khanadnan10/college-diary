import 'dart:typed_data';
import 'package:college_diary/core/providers/storage_provider.dart';
import 'package:college_diary/features/auth/controller/auth_controller.dart';
import 'package:college_diary/features/post/repository/post_repository.dart';
import 'package:college_diary/model/post_model.dart';
import 'package:college_diary/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
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

final getPostById = StreamProvider.autoDispose.family((ref, String name) {
  return ref.watch(postRepositoryProvider).getPostById(name);
});

final getAllPostProvider = StreamProvider.autoDispose((ref) {
  return ref.watch(postControllerProvider.notifier).getAllPost();
});

final getCurrentUserPost =
    FutureProvider.autoDispose.family((ref, String userId) {
  return ref.watch(postControllerProvider.notifier).getCurrentUserPost(userId);
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
          branch: 'cse',
          avatar: user.profilePic!,
          department: 'NIIST',
          userName: user.name,
          likes: [],
          images: imageUrl,
          content: title,
          dislikes: [],
          postType: postType,
          createdAt: DateTime.now(),
        );
        final res = await _postRepository.createPost(post);
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
      avatar: user.profilePic,
      branch: 'cse',
      department: 'NIIST',
      userName: user.name,
      likes: [],
      content: title,
      dislikes: [],
      postType: postType,
      createdAt: DateTime.now(),
    );
    final res = await _postRepository.createPost(post);
    state = false;
    return res.fold(
      (l) => showSnackBar(context, l.message),
      (r) {
        showSnackBar(context, 'Posted successfully!');
      },
    );
  }

  void deletePost(BuildContext context, Post post) async {
    try {
      if (post.images != null) {
        await _storageRepository.deleteFile(
          path: "post/${post.uid}",
          id: post.pid,
        );
      }
      await _postRepository.deletePost(post);
      if (context.mounted) showSnackBar(context, 'Post deleted successfully.');
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }

  Stream<List<Post>> getAllPost() {
    return _ref.watch(postRepositoryProvider).getAllPost();
  }

  Stream<Post> getPostById(String name) {
    return _ref.watch(postRepositoryProvider).getPostById(name);
  }

  Future<List<Post>> getCurrentUserPost(String userId) async {
    return await _ref.watch(postRepositoryProvider).getCurrentUserPost(userId);
  }

  void updateUserPost({
    required BuildContext context,
  }) async {
    try {
      state = true;
      final user = _ref.read(userProvider)!;

      final updateResponce = await _postRepository.updateUserPost(user);
      state = false;

      updateResponce.fold(
        (l) => showSnackBar(context, l.message),
        (r) {
          // _ref.read(userProvider.notifier).update((state) => user);
          showSnackBar(context, 'Post updated successfully.😃');
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
