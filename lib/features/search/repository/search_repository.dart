import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_diary/core/constants/firebase_collections.dart';
import 'package:college_diary/core/providers/firebase_provider.dart';
import 'package:college_diary/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchRepositoryProvider = Provider(
  (ref) {
    return SearchRepository(
      firestore: ref.watch(
        firebaseFirestoreProvider,
      ),
    );
  },
);

class SearchRepository {
  final FirebaseFirestore _firestore;
  SearchRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _users =>
      _firestore.collection(FirebaseCollection.userCollection);

  Stream<List<UserModel>> searchCommunity(String query) {
    String name = query.replaceFirst(query[0], query[0].toUpperCase());
    return _users
        .where(
          'name',
          isGreaterThanOrEqualTo: name.isEmpty ? 0 : name,
          isLessThan: name.isEmpty
              ? null
              : name.substring(0, name.length - 1) +
                  String.fromCharCode(
                    name.codeUnitAt(name.length - 1) + 1,
                  ),
        )
        .snapshots()
        .map((event) {
      List<UserModel> users = [];
      for (var community in event.docs) {
        users.add(UserModel.fromMap(community.data() as Map<String, dynamic>));
      }
      return users;
    });
  }
}
