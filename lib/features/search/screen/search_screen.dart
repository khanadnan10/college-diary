import 'package:college_diary/core/common/widgets/error_text.dart';
import 'package:college_diary/core/common/widgets/loader.dart';
import 'package:college_diary/features/search/controller/search_controller.dart';
import 'package:college_diary/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchTextProvider = StateProvider<String>((ref) => '');

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
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
        body: ref.watch(searchTextProvider).isEmpty
            ? const Center(
                child: Text(
                  'Try Capitalising the first Letter.. \n e.g Sandip',
                  textAlign: TextAlign.center,
                ),
              )
            : ref
                .watch(searchUserControllerProvider(
                    (ref.watch(searchTextProvider))))
                .when(
                  data: (communites) {
                    return ListView.builder(
                      itemCount: communites.length,
                      itemBuilder: (BuildContext context, int index) {
                        final community = communites[index];
                        if (communites.isEmpty) {
                          return const Center(
                            child: Text(
                              'No user found.',
                            ),
                          );
                        }
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(community.profilePic),
                          ),
                          subtitle: Text(community.enrollmentNumber
                              .toString()
                              .split(" ")[0]),
                          title: Text(community.name),
                          // onTap: () => navigateToCommunity(context, community.name),
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
