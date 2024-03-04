import 'package:college_diary/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50.0,
              backgroundImage: user!.profilePic.isEmpty
                  ? const NetworkImage(
                      'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                    )
                  : NetworkImage(user.profilePic),
            ),
            Text(user.name),
            Text(user.email),
            ElevatedButton.icon(
                onPressed: () =>
                    ref.read(authControllerProvider.notifier).signout(),
                icon: const Icon(Icons.exit_to_app),
                label: const Text('Logout'))
          ],
        ),
      ),
    );
  }
}
