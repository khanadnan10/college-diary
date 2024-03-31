import 'package:college_diary/core/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

class ProfileSettings extends ConsumerWidget {
  const ProfileSettings({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Settings',
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
              title: const Text('Edit Profile'),
              leading: const Icon(
                Icons.person,
              ),
              onTap: () =>
                  Routemaster.of(context).push(RouteName.editProfileScreen),
            ),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Text('😀🤣😋😎😍😪'),
            //     SizedBox(height: 10),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
