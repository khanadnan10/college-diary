import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_diary/core/constants/firebase_collections.dart';
import 'package:college_diary/core/failure.dart';
import 'package:college_diary/core/providers/firebase_provider.dart';
import 'package:college_diary/core/type_def.dart';
import 'package:college_diary/model/post_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final postRepositoryProvider = Provider((ref) {
  return PostRepository(firestore: ref.watch(firebaseFirestoreProvider));
});

class PostRepository {
  final FirebaseFirestore _firestore;
  PostRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _posts =>
      _firestore.collection(FirebaseCollection.postCollection);
  FutureVoid addPost(Post post) async {
    try {
      return right(await _posts.doc(post.pid).set(post.toMap()));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      if (kDebugMode) {
        print(
            "**************************************************************************${e.toString()}");
      }
      return left(Failure(e.toString()));
    }
  }
}
