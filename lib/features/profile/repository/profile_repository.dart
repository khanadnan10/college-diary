import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_diary/core/constants/firebase_collections.dart';
import 'package:college_diary/core/error/failure.dart';
import 'package:college_diary/core/providers/firebase_provider.dart';
import 'package:college_diary/core/type_def.dart';
import 'package:college_diary/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final profileRepositoryProvider = Provider((ref) {
  return ProfileRepository(
    firebaseFirestore: ref.watch(firebaseFirestoreProvider),
  );
});

class ProfileRepository {
  final FirebaseFirestore _firebaseFirestore;

  ProfileRepository({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;

  CollectionReference get _user =>
      _firebaseFirestore.collection(FirebaseCollection.userCollection);

  FutureVoid updateUser(UserModel user) async {
    try {
      await _user.doc(user.uid).update(
            user.toMap(),
          );
      return right(null);
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
