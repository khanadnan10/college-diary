import 'package:college_diary/features/auth/controller/auth_controller.dart';
import 'package:college_diary/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BannedScreen extends ConsumerWidget {
  const BannedScreen({super.key});

  void logout(WidgetRef ref) =>
      ref.watch(authControllerProvider.notifier).signout();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "You have been banned for unsual activity. Until the time you won't be able to modify your profile, post, comment, or perform any kind of activity. \n\n Contact Admin for further information.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Pallete.greyColor.withOpacity(0.5),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ElevatedButton.icon(
                onPressed: () => logout(ref),
                icon: const Icon(Icons.exit_to_app),
                label: const Text('Exit'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
