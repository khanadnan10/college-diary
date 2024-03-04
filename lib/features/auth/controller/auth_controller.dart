import 'package:college_diary/features/auth/repository/auth_provider.dart';
import 'package:college_diary/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import './../../../core/utils.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  return AuthController(
    authRepository: ref.watch(authRepositoryProvider),
    ref: ref,
  );
});

final getUserDataProvider = StreamProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
});

final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;
  AuthController({
    required AuthRepository authRepository,
    required Ref ref,
  })  : _authRepository = authRepository,
        _ref = ref,
        super(false);

  Stream<User?> get authStateChange => _authRepository.authStateChange;

  void signupUser({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
    required String enrollmentNumber,
  }) async {
    try {
      state = true;
      final user = await _authRepository.signupUser(
        name: name.trim(),
        email: email.trim(),
        password: password.trim(),
        phoneNumber: phoneNumber.trim(),
        enrollmentNumber: enrollmentNumber.trim(),
      );
      state = false;

      user.fold(
        (l) => showSnackBar(context, l.message),
        (userModel) => showSnackBar(context, "Account has been created"),
      );
    } catch (e) {
      state = false;
    }
  }

  void signin({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      state = true;
      final user =
          await _authRepository.signin(email: email, password: password);
      // if (kDebugMode) {
      //   print("singin controller -  ${user.fold((l) => l.message, (r) => r)}");
      // }
      state = false;
      user.fold(
        (l) {
          state = false;
          showSnackBar(context, l.message);
        },
        (userModel) =>
            _ref.read(userProvider.notifier).update((state) => userModel),
      );
    } catch (e) {
      state = false;
      if (context.mounted) showSnackBar(context, e.toString());
    }
  }

  Stream<UserModel?> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }

  Future<void> signout() async {
    state = true;
    await _authRepository.signoutUser();
    state = false;
  }

  void verifyInvitationCode({
    required BuildContext context,
    required String invitationCode,
  }) async {
    final res = await _authRepository.verifyInvitationCode(
        invitationCode: invitationCode);
    res.fold(
        (l) => showSnackBar(
              context,
              l.message,
            ),
        (r) => Routemaster.of(context).pop(true));
  }
}
