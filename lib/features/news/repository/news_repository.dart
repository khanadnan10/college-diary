import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_diary/core/constants/firebase_collections.dart';
import 'package:college_diary/core/error/failure.dart';
import 'package:college_diary/core/providers/firebase_provider.dart';
import 'package:college_diary/core/type_def.dart';
import 'package:college_diary/model/news_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final newsRepositoryProvider = Provider((ref) {
  return NewsRepository(
    firebaseFirestore: ref.watch(firebaseFirestoreProvider),
  );
});

class NewsRepository {
  final FirebaseFirestore _firebaseFirestore;

  NewsRepository({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;

  //! Reference to the news collection
  CollectionReference get _news =>
      _firebaseFirestore.collection(FirebaseCollection.newsCollection);

  //* Create News
  FutureEither<String> createNews(News news) async {
    try {
      await _news.doc(news.id).set(news.toMap());
      return right('News created successfully.');
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //* Get News
  Stream<List<News>> getNews() {
    return _news.orderBy("createdAt", descending: true).snapshots().map(
        (event) => event.docs
            .map((e) => News.fromMap(e.data() as Map<String, dynamic>))
            .toList());
  }

  //* get News By Id
  FutureEither<News> getNewsById(String newsId) async {
    try {
      final news = await _news.doc(newsId).get();

      if (news.exists) {
        return right(News.fromMap(news.data() as Map<String, dynamic>));
      } else {
        return left(Failure('News not found!'));
      }
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      return left(
        Failure(e.toString()),
      );
    }
  }

  //* Delete News By Id
  FutureEither<String> deleteNewsbyId(String newsId) async {
    try {
      await _news.doc(newsId).delete();
      return right('News deleted successfully!');
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      return left(
        Failure(e.toString()),
      );
    }
  }

  //* Edit News
  FutureEither<String> editNewsbyId(News news) async {
    try {
      await _news.doc(news.id).update(news.toMap());
      return right('News updated successfully!');
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      return left(
        Failure(e.toString()),
      );
    }
  }
}
