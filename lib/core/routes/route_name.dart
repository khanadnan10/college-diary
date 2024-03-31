class RouteName {
  static const String initial = '/';

  static const String invitationVerification = '/invitation-verification';

  static const String homeScreen = '/home-screen';
  static const String bottomNavbarScreen = '/bottom-nav-screen';

  static const String bannedScreen = '/banned';

  static const String searchScreen = '/search-screen';

  static const String postDetailScreen = '/post-detail/:postId';

  static const String profileScreen = '/profile/:uid';
  static const String profileSettingsScreen = '/profile/settings';
  static const String editProfileScreen = '/profile/settings/edit';

  static const String createNewsScreen = '/create-news';
  static const String newsDetailScreen = '/news-detail/:newsId';

  /*----------------------------------------
   ADMIN
  -----------------------------------------*/
  static const String adminBottomNavBarScreen = '/admin';
  static const String adminDashboardScreen = '/admin/dashboard';
  static const String adminStatusScreen = '/admin/dashboard/status/:query';
}
