import 'dart:typed_data';
import 'package:college_diary/core/error/failure.dart';
import 'package:college_diary/core/providers/firebase_provider.dart';
import 'package:college_diary/core/type_def.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
// import 'package:uuid/uuid.dart';

final storageRepositoryProvider = Provider(
  (ref) => StorageRepository(
    firebaseStorage: ref.watch(firebaseStorageProvider),
  ),
);

class StorageRepository {
  final FirebaseStorage _firebaseStorage;

  StorageRepository({required FirebaseStorage firebaseStorage})
      : _firebaseStorage = firebaseStorage;

  FutureEither<String> storeFile({
    required String path,
    required String id,
    required Uint8List file,
    bool isPublicPost = true,
  }) async {
    try {
      final Reference ref = _firebaseStorage.ref().child(path).child(id);
      UploadTask uploadTask = ref.putData(file);

      final snapshot = await uploadTask;

      return right(await snapshot.ref.getDownloadURL());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<bool> deleteFile({
    required String path,
    required String id,
  }) async {
    try {
      final Reference ref = _firebaseStorage.ref().child(path).child(id);
      await ref.delete();
      return right(true);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
