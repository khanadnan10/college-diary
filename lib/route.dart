import 'package:college_diary/core/banned_screen.dart';
import 'package:college_diary/core/invitation_verification.dart';
import 'package:college_diary/core/route_name.dart';
import 'package:college_diary/features/auth/screen/auth.dart';
import 'package:college_diary/features/home/screen/home_screen.dart';
import 'package:college_diary/features/home/screen/bottom_nav_bar.dart';
import 'package:college_diary/features/news/screen/create_news.dart';
import 'package:college_diary/features/news/screen/news_detail_screen.dart';
import 'package:college_diary/features/post/screen/post_detail_screen.dart';
import 'package:college_diary/features/profile/screen/edit_profile.dart';
import 'package:college_diary/features/profile/screen/profile_screen.dart';
import 'package:college_diary/features/profile/screen/profile_settings.dart';
import 'package:college_diary/features/search/screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute = RouteMap(routes: {
  RouteName.initial: (_) => const MaterialPage(
        child: AuthScreen(),
      ),
  RouteName.invitationVerification: (_) => const MaterialPage(
        child: InvitationVerification(),
      ),
});
final bannedRoute = RouteMap(routes: {
  RouteName.bannedScreen: (_) => const MaterialPage(
        child: BannedScreen(),
      ),
});

final loggedInRoute = RouteMap(
  routes: {
    RouteName.initial: (_) => const MaterialPage(
          child: BottomNavBar(),
        ),
    RouteName.homeScreen: (_) => const MaterialPage(
          child: HomeScreen(),
        ),
    RouteName.searchScreen: (_) => const MaterialPage(
          child: SearchScreen(),
        ),
    RouteName.postDetailScreen: (route) => MaterialPage(
          child: PostDetailScreen(
            postId: route.pathParameters['postId']!,
          ),
        ),
    RouteName.profileScreen: (route) => MaterialPage(
          child: ProfileScreen(
            uid: route.pathParameters['uid']!,
          ),
        ),
    RouteName.createNewsScreen: (_) => const MaterialPage(
          child: CreateNews(),
        ),
    RouteName.newsDetailScreen: (route) => MaterialPage(
          child: NewsDetailsScreen(
            newsId: route.pathParameters['newsId']!,
          ),
        ),
    RouteName.profileSettingsScreen: (_) => const MaterialPage(
          child: ProfileSettings(),
        ),
    RouteName.editProfileScreen: (_) => const MaterialPage(
          child: EditProfile(),
        ),
  },
  onUnknownRoute: (path) => const Redirect(RouteName.initial),
);
