// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:college_diary/core/widgets/error_text.dart';
import 'package:college_diary/core/widgets/loader.dart';
import 'package:college_diary/features/admin/controller/admin_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserStatus extends ConsumerWidget {
  const UserStatus({
    super.key,
    required this.users,
  });

  final String users;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          if (users == 'isVerifiedByAdmin')
            ref.watch(getVerifiedUserAdminControllerProvider(context)).when(
                  data: (data) => ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final user = data[index];
                      if (users.isEmpty) {
                        return const Center(
                          child: Text('No user'),
                        );
                      }
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.profilePic!),
                        ),
                        title: Text(user.name),
                        subtitle: Text(user.enrollmentNumber),
                      );
                    },
                  ),
                  error: (error, st) => ErrorText(error: error.toString()),
                  loading: () => const Loader(),
                ),
          if (users == 'Unverified')
            ref.watch(getUnverifiedUserAdminControllerProvider(context)).when(
                  data: (data) => ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final user = data[index];
                      if (users.isEmpty) {
                        return const Center(
                          child: Text('No user'),
                        );
                      }
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.profilePic!),
                        ),
                        title: Text(user.name),
                        subtitle: Text(user.enrollmentNumber),
                      );
                    },
                  ),
                  error: (error, st) => ErrorText(error: error.toString()),
                  loading: () => const Loader(),
                ),
          if (users == 'isBanned')
            ref.watch(getBannedUserAdminControllerProvider(context)).when(
                  data: (data) => ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final user = data[index];
                      if (users.isEmpty) {
                        return const Center(
                          child: Text('No user'),
                        );
                      }
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.profilePic!),
                        ),
                        title: Text(user.name),
                        subtitle: Text(user.enrollmentNumber),
                      );
                    },
                  ),
                  error: (error, st) => ErrorText(error: error.toString()),
                  loading: () => const Loader(),
                ),
          if (users == 'allUsers')
            ref.watch(getAllUserAdminControllerProvider(context)).when(
                  data: (data) => ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final user = data[index];
                      if (users.isEmpty) {
                        return const Center(
                          child: Text('No user'),
                        );
                      }
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.profilePic!),
                        ),
                        title: Text(user.name),
                        subtitle: Text(user.enrollmentNumber),
                      );
                    },
                  ),
                  error: (error, st) => ErrorText(error: error.toString()),
                  loading: () => const Loader(),
                ),
        ],
      ),
    );
  }
}


/*----------------------------------------
 ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          if (users.isEmpty) {
            return const Center(
              child: Text('No user'),
            );
          }
          return const ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage('user.profilePic!'),
            ),
            title: Text('user.name'),
            subtitle: Text('user.enrollmentNumber'),
          );
        },
      ),
-----------------------------------------*/