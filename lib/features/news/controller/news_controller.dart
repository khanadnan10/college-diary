import 'dart:typed_data';
import 'package:college_diary/core/constants/department_list.dart';
import 'package:college_diary/core/providers/storage_provider.dart';
import 'package:college_diary/features/auth/controller/auth_controller.dart';
import 'package:college_diary/features/news/repository/news_repository.dart';
import 'package:college_diary/model/news_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import '../../../core/utils.dart';
import 'package:uuid/uuid.dart';

final newsControllerProvider =
    StateNotifierProvider<NewsController, bool>((ref) {
  return NewsController(
    newsRepository: ref.watch(newsRepositoryProvider),
    ref: ref,
    storageRepository: ref.watch(storageRepositoryProvider),
  );
});

final getNewsProvider = StreamProvider((ref) {
  return ref.watch(newsControllerProvider.notifier).getAllNews();
});
final getNewsByIdProvider = FutureProvider.family((ref, String id) {
  return ref.watch(newsControllerProvider.notifier).getNewsById(id);
});

class NewsController extends StateNotifier<bool> {
  final NewsRepository _newsRepository;
  final Ref _ref;
  final StorageRepository _storageRepository;

  NewsController(
      {required NewsRepository newsRepository,
      required Ref ref,
      required StorageRepository storageRepository})
      : _newsRepository = newsRepository,
        _ref = ref,
        _storageRepository = storageRepository,
        super(false);

  //* Create News
  void createNews({
    required BuildContext context,
    required String title,
    required String content,
    required String department,
    required String? link,
    required Uint8List? file,
  }) async {
    final user = _ref.read(userProvider)!;
    final newsId = const Uuid().v1();
    try {
      state = true;

      String? imageLink;

      final uploadUrl = await _storageRepository.storeFile(
        path: "news",
        id: newsId,
        file: file!,
      );
      uploadUrl.fold((l) => showSnackBar(context, l.message),
          (downloadLink) => imageLink = downloadLink);
      News news = News(
        id: newsId,
        title: title,
        image: imageLink,
        content: content,
        link: link,
        author: user.name,
        department: department,
        createdAt: DateTime.now(),
      );

      final res = await _newsRepository.createNews(news);
      state = false;

      res.fold((l) => showSnackBar(context, l.message), (r) {
        showSnackBar(context, r);
        if (context.mounted) Routemaster.of(context).pop();
      });
    } catch (e) {
      state = false;

      if (context.mounted) showSnackBar(context, e.toString());
    }
  }

  void createTextNews({
    required BuildContext context,
    required String title,
    required String department,
    required String content,
    required String? link,
  }) async {
    final user = _ref.read(userProvider)!;
    final newsId = const Uuid().v1();
    try {
      state = true;
      News news = News(
        id: newsId,
        title: title,
        image: null,
        link: link,
        content: content,
        author: user.name,
        department: department,
        createdAt: DateTime.now(),
      );

      final res = await _newsRepository.createNews(news);
      state = false;

      res.fold((l) => showSnackBar(context, l.message), (r) {
        showSnackBar(context, r);
        if (context.mounted) Routemaster.of(context).pop();
      });
    } catch (e) {
      state = false;

      if (context.mounted) showSnackBar(context, e.toString());
    }
  }

  //* Get News
  Stream<List<News>> getAllNews() {
    return _newsRepository.getNews();
  }

  Future<News> getNewsById(String newsId) async {
    final res = await _newsRepository.getNewsById(newsId);
    return res.fold((l) {
      return [] as News;
    }, (news) {
      return news;
    });
  }

  void deletePost(BuildContext context, News news) async {
    try {
      if (news.image != null) {
        await _storageRepository.deleteFile(
          path: "news",
          id: news.id,
        );
      }
      await _newsRepository.deleteNewsbyId(news.id);
      if (context.mounted) showSnackBar(context, 'Post deleted successfully.');
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      if (context.mounted) {
        showSnackBar(context, e.toString());
      }
    }
  }
}
