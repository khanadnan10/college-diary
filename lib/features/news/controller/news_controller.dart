import 'dart:typed_data';

import 'package:college_diary/core/providers/storage_provider.dart';
import 'package:college_diary/core/type_def.dart';
import 'package:college_diary/features/auth/controller/auth_controller.dart';
import 'package:college_diary/features/news/repository/news_repository.dart';
import 'package:college_diary/model/news_model.dart';
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

final getNewsProvider = FutureProvider((ref) async {
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
        author: user.name,
        department: 'cse',
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
    required String content,
  }) async {
    final user = _ref.read(userProvider)!;
    final newsId = const Uuid().v1();
    try {
      state = true;
      News news = News(
        id: newsId,
        title: title,
        image: null,
        content: content,
        author: user.name,
        department: 'cse',
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
  Future<List<News>> getAllNews() async {
    return await _newsRepository.getNews();
  }

  Future<News> getNewsById(String newsId) async {
    final res = await _newsRepository.getNewsById(newsId);
    return res.fold((l) {
      return [] as News;
    }, (news) {
      return news;
    });
  }
}
