import 'package:college_diary/core/banned_screen.dart';
import 'package:college_diary/core/route_name.dart';
import 'package:college_diary/core/widgets/error_text.dart';
import 'package:college_diary/core/widgets/loader.dart';
import 'package:college_diary/features/auth/controller/auth_controller.dart';
import 'package:college_diary/features/search/controller/search_controller.dart';
import 'package:college_diary/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';

final searchTextProvider = StateProvider<String>((ref) => '');

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  void navigateToProfileScreen(BuildContext context, String userId) {
    // Routemaster.of(context).push("/profile/$uid");
    Routemaster.of(context)
        .push((RouteName.profileScreen).replaceFirst(':uid', userId));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          title: TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onFieldSubmitted: (value) {
              ref.watch(searchTextProvider.notifier).update((_) => value);
            },
            validator: (value) {
              if (value!.isEmpty) {
                return "You have nothing to search for...";
              }
              return null;
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.search,
                size: 24.0,
              ),
              hintText: "Looking for someone?",
              hintStyle: TextStyle(
                color: Pallete.greyColor.withOpacity(0.3),
                fontWeight: FontWeight.w400,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Pallete.greyColor.withOpacity(0.1),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Pallete.greyColor.withOpacity(0.2),
                ),
              ),
              isDense: true,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Pallete.blueColor.withOpacity(0.1),
                ),
              ),
            ),
          ),
        ),
        body: ref.watch(userProvider)!.isBanned
            ? const BannedScreen()
            : ref.watch(searchTextProvider).isEmpty
                ? Center(
                    child: Text(
                      'Didn\'t found the student?\n Try capitalising the first Letter.. \n e.g Sandip',
                      style: TextStyle(
                        color: Pallete.greyColor.withOpacity(0.5),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                : ref
                    .watch(searchUserControllerProvider(
                        (ref.watch(searchTextProvider))))
                    .when(
                      data: (users) {
                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: users.length,
                          itemBuilder: (BuildContext context, int index) {
                            final user = users[index];
                            if (users.isEmpty) {
                              return const Center(
                                child: Text(
                                  'No user found.',
                                ),
                              );
                            }
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(user.profilePic!),
                              ),
                              subtitle: Text(user.enrollmentNumber.toString()),
                              title: Text(user.name),
                              onTap: () =>
                                  navigateToProfileScreen(context, user.uid),
                            );
                          },
                        );
                      },
                      error: (error, st) => ErrorText(error: error.toString()),
                      loading: () => const Loader(),
                    ),
      ),
    );
  }
}
