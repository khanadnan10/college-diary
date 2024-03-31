import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_diary/core/constants/firebase_collections.dart';
import 'package:college_diary/core/error/failure.dart';
import 'package:college_diary/core/providers/firebase_provider.dart';
import 'package:college_diary/core/type_def.dart';
import 'package:college_diary/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final adminRepositoryProvider = Provider((ref) {
  return AdminRepository(
      firebaseFirestore: ref.read(firebaseFirestoreProvider));
});

class AdminRepository {
  final FirebaseFirestore _firebaseFirestore;
  const AdminRepository({required FirebaseFirestore firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore;

  CollectionReference get _news =>
      _firebaseFirestore.collection(FirebaseCollection.userCollection);

  //* To fetch all the user available in the collection
  FutureEither<List<UserModel>> getAllUser() async {
    try {
      List<UserModel> users = [];
      final query = await _news.get();
      if (query.docs.isNotEmpty) {
        for (var user in query.docs) {
          users.add(UserModel.fromMap(user.data() as Map<String, dynamic>));
        }
      }
      return right(users);
    } on FirebaseException catch (e) {
      return left(Failure(e.message ?? "Some error occured"));
    }
  }

  FutureEither<List<UserModel>> getVerifiedUser() async {
    try {
      List<UserModel> users = [];
      final query = await _news
          .where(
            'isVerifiedByAdmin',
            isEqualTo: true,
          )
          .get();
      if (query.docs.isNotEmpty) {
        for (var user in query.docs) {
          users.add(UserModel.fromMap(user.data() as Map<String, dynamic>));
        }
      }
      return right(users);
    } on FirebaseException catch (e) {
      return left(Failure(e.message ?? "Some error occured"));
    }
  }

  FutureEither<List<UserModel>> getUnverifiedUser() async {
    try {
      List<UserModel> users = [];
      final query = await _news
          .where(
            'isVerifiedByAdmin',
            isEqualTo: false,
          )
          .get();
      if (query.docs.isNotEmpty) {
        for (var user in query.docs) {
          users.add(UserModel.fromMap(user.data() as Map<String, dynamic>));
        }
      }
      return right(users);
    } on FirebaseException catch (e) {
      return left(Failure(e.message ?? "Some error occured"));
    }
  }

  FutureEither<List<UserModel>> getBannedUser() async {
    try {
      List<UserModel> users = [];
      final query = await _news.where('isBanned', isEqualTo: true).get();
      if (query.docs.isNotEmpty) {
        for (var user in query.docs) {
          users.add(UserModel.fromMap(user.data() as Map<String, dynamic>));
        }
      }
      return right(users);
    } on FirebaseException catch (e) {
      return left(Failure(e.message ?? "Some error occured"));
    }
  }
}
