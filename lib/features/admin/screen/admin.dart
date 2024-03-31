import 'package:college_diary/core/widgets/error_text.dart';
import 'package:college_diary/core/widgets/loader.dart';
import 'package:college_diary/features/admin/controller/admin_controller.dart';
import 'package:college_diary/features/admin/screen/user_status.dart';
import 'package:college_diary/features/admin/widgets/user_count_card.dart';
import 'package:college_diary/features/auth/controller/auth_controller.dart';
import 'package:college_diary/model/user_model.dart';
import 'package:college_diary/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final admin = ref.watch(userProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.blueColor,
        foregroundColor: Pallete.whiteColor,
        title: const Text('Dashboard'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: admin != null
              ? ref.watch(getAllUserAdminControllerProvider(context)).when(
                    data: (users) {
                      List<UserModel> verifiedUsers = [];
                      List<UserModel> bannedUsers = [];
                      List<UserModel> unverifiedusers = [];
                      for (UserModel user in users) {
                        if (user.isVerifiedByAdmin) {
                          verifiedUsers.add(user);
                        } else {
                          unverifiedusers.add(user);
                        }
                        if (user.isBanned) {
                          bannedUsers.add(user);
                        }
                      }
                      return Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              color: Pallete.blueColor,
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 32,
                                  backgroundColor: Pallete.whiteColor,
                                  child: CircleAvatar(
                                    radius: 30.0,
                                    backgroundImage:
                                        NetworkImage(admin.profilePic!),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      admin.name,
                                      style: const TextStyle(
                                        fontSize: 18.0,
                                        color: Pallete.whiteColor,
                                      ),
                                    ),
                                    const Text(
                                      'Admin',
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: Pallete.whiteColor,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: UserCountCard(
                                  text: "Verified",
                                  count: verifiedUsers.length,
                                  color: const Color(0xFF2196F3),
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const UserStatus(
                                        users: 'isVerifiedByAdmin',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: UserCountCard(
                                  text: "Unverified",
                                  count: unverifiedusers.length,
                                  color: const Color(0xFFFFC107),
                                  onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const UserStatus(
                                        users: 'Unverified',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: UserCountCard(
                                  text: "Banned",
                                  count: bannedUsers.length,
                                  color: const Color(0xFFFF5722),
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const UserStatus(
                                        users: 'isBanned',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: UserCountCard(
                                  text: "Total Students",
                                  count: users.isEmpty ? 0 : users.length,
                                  color: const Color(0xFF4CAF50),
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const UserStatus(users: 'allUsers'),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                    error: (error, st) => ErrorText(error: error.toString()),
                    loading: () => const Loader(),
                  )
              : const Loader(),
        ),
      ),
    );
  }
}
