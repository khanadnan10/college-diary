import 'package:flutter_riverpod/flutter_riverpod.dart';

final bottomNavBarProvider = StateProvider.autoDispose<int>((ref) {
  return 0;
});
