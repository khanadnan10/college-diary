import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:college_diary/core/constants/firebase_collections.dart';
import 'package:college_diary/core/providers/firebase_provider.dart';
import 'package:college_diary/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import 'package:college_diary/core/failure.dart';
import 'package:college_diary/core/type_def.dart';

final authRepositoryProvider = Provider((ref) {
  return AuthRepository(
    firestore: ref.watch(firebaseFirestoreProvider),
    auth: ref.watch(firebaseAuthProvider),
  );
});

class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  })  : _auth = auth,
        _firestore = firestore;

  CollectionReference get _user =>
      _firestore.collection(FirebaseCollection.userCollection);
  CollectionReference get _invitationCode =>
      _firestore.collection(FirebaseCollection.passcodeCollection);

  Stream<User?> get authStateChange => _auth.authStateChanges();

  FutureEither<String> deleteUser() async {
    try {
      await _user.doc(_auth.currentUser!.uid).delete();
      await _auth.currentUser!.delete();
      return right("Account has been deleted Successfully.");
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<UserModel?> signin({
    required String email,
    required String password,
  }) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        return left(Failure("Email and password are required"));
      }

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        final userData = await getUserData(userCredential.user!.uid).first;
        return right(userData);
      } else {
        return left(Failure('No user found with this email.'));
      }
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<User?> signupUser({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
    required String enrollmentNumber,
  }) async {
    try {
      if (name.isNotEmpty ||
          email.isNotEmpty ||
          password.isNotEmpty ||
          phoneNumber.length == 10 ||
          enrollmentNumber.isNotEmpty) {
        // check if the enrollment is already assigned to other user

        final enrollmentFound =
            await checkValidEnrollment(enrollmentNumber.toLowerCase());

        if (!enrollmentFound) {
          throw "Enrollment Already exist";
        }

        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);

        UserModel user = UserModel(
          uid: userCredential.user!.uid,
          name: name,
          email: email,
          joinedClub: [],
          phoneNumber: phoneNumber,
          enrollmentNumber: enrollmentNumber.toUpperCase(),
          profilePic:
              "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png",
          isVerifiedByAdmin: false,
          isBanned: false,
          isAdmin: false,
        );
        await _user.doc(user.uid).set(user.toMap(), SetOptions(merge: true));
        return right(userCredential.user);
      } else {
        return left(Failure('Something went wrong!'));
      }
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<UserModel> getUserData(String uid) {
    return _user.doc(uid).snapshots().map(
          (event) => UserModel.fromMap(event.data() as Map<String, dynamic>),
        );
  }

  Future<bool> checkValidEnrollment(String enrollment) async {
    return await _user
        .where('enrollmentNumber', isEqualTo: enrollment)
        .get()
        .then((value) => value.docs.isEmpty);
  }

  FutureEither<bool> verifyInvitationCode(
      {required String invitationCode}) async {
    try {
      final querySnapshot = await _invitationCode.get();

      for (var documentSnapshot in querySnapshot.docs) {
        var code = (documentSnapshot.data() as Map<String, dynamic>)['code'];
        if (code.toString() == invitationCode) {
          return right(true);
        }
      }
      return left(Failure('Invitation code doesn\'t matches.'));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  void signoutUser() async {
    await _auth.signOut();
  }
}
