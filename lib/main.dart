import 'package:college_diary/firebase_options.dart';
import 'package:college_diary/route.dart';
import 'package:college_diary/theme/pallete.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'College Diary',
      theme: Pallete.lightModeAppTheme,
      routerDelegate:
          RoutemasterDelegate(routesBuilder: (context) => loggedOutRoute),
      routeInformationParser: const RoutemasterParser(),
    );
  }
}
