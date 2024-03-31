import 'package:college_diary/features/admin/repository/admin_repository.dart';
import 'package:college_diary/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils.dart';

final adminControllerProvider = Provider((ref) {
  return AdminController(
    adminRepository: ref.watch(adminRepositoryProvider),
  );
});

final getAllUserAdminControllerProvider =
    FutureProvider.family((ref, BuildContext context) async {
  return ref.watch(adminControllerProvider).getAllUser(context);
});
final getVerifiedUserAdminControllerProvider =
    FutureProvider.family((ref, BuildContext context) async {
  return ref.watch(adminControllerProvider).getVerifiedUser(context);
});
final getUnverifiedUserAdminControllerProvider =
    FutureProvider.family((ref, BuildContext context) async {
  return ref.watch(adminControllerProvider).getUnverifiedUser(context);
});
final getBannedUserAdminControllerProvider =
    FutureProvider.family((ref, BuildContext context) async {
  return ref.watch(adminControllerProvider).getBannedUser(context);
});

class AdminController extends StateNotifier<bool> {
  final AdminRepository _adminRepository;

  AdminController({required AdminRepository adminRepository})
      : _adminRepository = adminRepository,
        super(false);

  Future<List<UserModel>> getAllUser(BuildContext context) async {
    state = true;
    List<UserModel>? allUsers = [];
    final res = await _adminRepository.getAllUser();
    res.fold(
        (l) => context.mounted ? showSnackBar(context, l.message) : null,
        (users) => users
            .map(
              (e) => allUsers.add(e),
            )
            .toList());
    state = false;
    return allUsers;
  }

  Future<List<UserModel>> getVerifiedUser(BuildContext context) async {
    state = true;
    List<UserModel>? allUsers = [];
    final res = await _adminRepository.getVerifiedUser();
    res.fold(
        (l) => context.mounted ? showSnackBar(context, l.message) : null,
        (users) => users
            .map(
              (e) => allUsers.add(e),
            )
            .toList());
    state = false;
    return allUsers;
  }

  Future<List<UserModel>> getUnverifiedUser(BuildContext context) async {
    state = true;
    List<UserModel>? allUsers = [];
    final res = await _adminRepository.getUnverifiedUser();
    res.fold(
        (l) => context.mounted ? showSnackBar(context, l.message) : null,
        (users) => users
            .map(
              (e) => allUsers.add(e),
            )
            .toList());
    state = false;
    return allUsers;
  }

  Future<List<UserModel>> getBannedUser(BuildContext context) async {
    state = true;
    List<UserModel>? allUsers = [];
    final res = await _adminRepository.getBannedUser();
    res.fold(
        (l) => context.mounted ? showSnackBar(context, l.message) : null,
        (users) => users
            .map(
              (e) => allUsers.add(e),
            )
            .toList());
    state = false;
    return allUsers;
  }
}
