import 'package:college_diary/core/common/widgets/loader.dart';
import 'package:college_diary/core/constants/list_of_screen.dart';
import 'package:college_diary/features/auth/controller/auth_controller.dart';
import 'package:college_diary/features/home/controller/bottom_nav_bar_controller.dart';
import 'package:college_diary/features/post/screen/add_post.dart';
import 'package:college_diary/theme/pallete.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(authControllerProvider);
    final selectedIndex = ref.watch(bottomNavBarProvider);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.red,
        bottomNavigationBar: Container(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
          decoration: const BoxDecoration(),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(26.0),
            child: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              elevation: 0,
              backgroundColor: Pallete.blueColor,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.add_box_rounded,
                  ),
                  label: 'Business',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.newspaper),
                  label: 'News',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              onTap: (val) {
                if (val == 2) {
                  addPostBottomModelSheet(context);
                } else {
                  ref
                      .watch(bottomNavBarProvider.notifier)
                      .update((state) => val);
                }
              },
              iconSize: 30,
              currentIndex: selectedIndex,
              selectedItemColor: Pallete.whiteColor,
              unselectedItemColor: Pallete.whiteColor.withOpacity(0.5),
            ),
          ),
        ),
        body: isLoading ? const Loader() : screens[selectedIndex],
      ),
    );
  }
}
