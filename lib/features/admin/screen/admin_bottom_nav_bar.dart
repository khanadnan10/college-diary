import 'package:college_diary/core/widgets/loader.dart';
import 'package:college_diary/core/constants/list_of_screen.dart';
import 'package:college_diary/features/auth/controller/auth_controller.dart';
import 'package:college_diary/features/home/controller/bottom_nav_bar_controller.dart';
import 'package:college_diary/theme/pallete.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class AdminBottomNavBar extends ConsumerStatefulWidget {
  const AdminBottomNavBar({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends ConsumerState<AdminBottomNavBar> {
  final TextEditingController postController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);
    final selectedIndex = ref.watch(adminbottomNavBarProvider);
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          color: Colors.transparent,
          child: ClipRRect(
            child: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              elevation: 0,
              backgroundColor: Pallete.blueColor,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'search',
                ),
                // BottomNavigationBarItem(
                //   icon: Icon(
                //     Icons.add_box_rounded,
                //   ),
                //   label: 'Business',
                // ),
                // BottomNavigationBarItem(
                //   icon: Icon(Icons.newspaper),
                //   label: 'News',
                // ),
                // BottomNavigationBarItem(
                //   icon: Icon(Icons.person),
                //   label: 'Profile',
                // ),
              ],
              onTap: (val) {
                ref
                    .watch(adminbottomNavBarProvider.notifier)
                    .update((state) => val);
              },
              iconSize: 30,
              currentIndex: selectedIndex,
              selectedItemColor: Pallete.whiteColor,
              unselectedItemColor: Pallete.whiteColor.withOpacity(0.5),
            ),
          ),
        ),
        body: isLoading
            ? const Loader()
            : adminBottomNavBarScreens[selectedIndex],
      ),
    );
  }
}
