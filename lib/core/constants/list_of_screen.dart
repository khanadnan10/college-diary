import 'package:college_diary/core/providers/firebase_provider.dart';
import 'package:college_diary/features/admin/screen/admin.dart';
import 'package:college_diary/features/auth/controller/auth_controller.dart';
import 'package:college_diary/features/home/screen/home_screen.dart';
import 'package:college_diary/features/news/screen/news_screen.dart';
import 'package:college_diary/features/post/screen/add_post.dart';
import 'package:college_diary/features/profile/screen/profile_screen.dart';
import 'package:college_diary/features/search/screen/search_screen.dart';
import 'package:college_diary/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

List<Widget> bottomNavScreens = [
  const HomeScreen(),
  const SearchScreen(),
  Consumer(
    builder: (context, ref, _) {
      final userBanned = ref.watch(userProvider)!.isBanned;
      return userBanned
          ? Center(
              child: Text(
                "You have been banned for unsual activity. Until the time you won't be able to modify your profile, post, comment, or perform any kind of activity. \n\n Contact Admin for further information.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Pallete.greyColor.withOpacity(0.5),
                ),
              ),
            )
          : const AddPostScreen();
    },
  ),
  const NewsScreen(),
  Consumer(
    builder: (context, ref, _) {
      final uid = ref.watch(firebaseAuthProvider).currentUser!.uid;
      return ProfileScreen(uid: uid);
    },
  ),
];

List<Widget> adminBottomNavBarScreens = [
  const AdminDashboardScreen(),
  const Center(
    child: Text('Sample space'),
  )
];
