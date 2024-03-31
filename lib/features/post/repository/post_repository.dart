import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_diary/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:college_diary/core/constants/firebase_collections.dart';
import 'package:college_diary/core/error/failure.dart';
import 'package:college_diary/core/providers/firebase_provider.dart';
import 'package:college_diary/core/type_def.dart';
import 'package:college_diary/model/post_model.dart';

final postRepositoryProvider = Provider((ref) {
  return PostRepository(
      firestore: ref.watch(firebaseFirestoreProvider), ref: ref);
});

class PostRepository {
  final FirebaseFirestore _firestore;

  PostRepository({required FirebaseFirestore firestore, required Ref ref})
      : _firestore = firestore;
  CollectionReference get _posts =>
      _firestore.collection(FirebaseCollection.postCollection);

  FutureVoid createPost(Post post) async {
    try {
      final res = await _posts.doc(post.pid).set(post.toMap());
      return right(res);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<bool> deletePost(Post post) async {
    try {
      await _posts.doc(post.pid).delete();
      return right(true);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<Post>> getAllPost() => _posts
      .orderBy("createdAt", descending: true)
      .snapshots()
      .map((event) => event.docs
          .map((e) => Post.fromMap(e.data() as Map<String, dynamic>))
          .toList());

  Stream<Post> getPostById(String name) {
    return _posts
        .doc(name)
        .snapshots()
        .map((event) => Post.fromMap(event.data() as Map<String, dynamic>));
  }

  Future<List<Post>> getCurrentUserPost(String userId) async {
    Query query;

    query = _posts
        .orderBy('createdAt', descending: true)
        .where('uid', isEqualTo: userId);

    final querySnapshot = await query.get();

    return querySnapshot.docs
        .map((doc) => Post.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }

  FutureVoid updateUserPost(UserModel user) async {
    try {
      QuerySnapshot querySnapshot =
          await _posts.where('uid', isEqualTo: user.uid).get();

      if (querySnapshot.docs.isEmpty) {
        return right(null);
      }

      for (QueryDocumentSnapshot pocDoc in querySnapshot.docs) {
        await _posts.doc(pocDoc.id).update({
          "avatar": user.profilePic,
          "userName": user.name,
        });
      }
      return right(null);
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // FutureVoid updateUserPostAsPerProfileUpdate(String userId) async {
  //   try {
  //     QuerySnapshot querySnapshot =
  //         await _posts.where('uid', isEqualTo: userId).get();

  //     if (querySnapshot.docs.isEmpty) {
  //       return right(null);
  //     }

  //     for (QueryDocumentSnapshot pocDoc in querySnapshot.docs) {
  //       await _posts.doc(pocDoc.id).update({});
  //     }
  //     return left(Failure('User has no posts!'));
  //   } catch (e) {
  //     return left(Failure(e.toString()));
  //   }
  // }
}
