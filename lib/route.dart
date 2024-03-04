import 'package:college_diary/core/invitation_verification.dart';
import 'package:college_diary/core/route_name.dart';
import 'package:college_diary/features/auth/screen/auth.dart';
import 'package:college_diary/features/home/screen/home_screen.dart';
import 'package:college_diary/features/home/screen/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute = RouteMap(routes: {
  RouteName.initial: (_) => const MaterialPage(child: AuthScreen()),
  RouteName.invitationVerification: (_) =>
      const MaterialPage(child: InvitationVerification()),
});

final loggedInRoute = RouteMap(routes: {
  RouteName.initial: (_) => const MaterialPage(child: BottomNavBar()),
  RouteName.homeScreen: (_) => const MaterialPage(child: HomeScreen()),
});
