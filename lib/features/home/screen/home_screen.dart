import 'package:college_diary/core/common/widgets/error_text.dart';
import 'package:college_diary/core/common/widgets/loader.dart';
import 'package:college_diary/core/widgets/post_card.dart';
import 'package:college_diary/features/post/controller/post_controller.dart';
import 'package:college_diary/model/post_model.dart';
import 'package:college_diary/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void navigateToPostDetailScreen(BuildContext context, Post post) {
    Routemaster.of(context).push("/post-detail/${post.pid}");
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Pallete.blueColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Pallete.blueColor,
              expandedHeight: 100,
              floating: true,
              snap: true,
              flexibleSpace: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Flexible(
                      child: Text(
                        "Explore Feed",
                        style: TextStyle(
                          color: Pallete.whiteColor,
                          fontSize: 24.0,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                    //TODO: Show latest News by Admin here
                  ],
                ),
              ),
            ),
          ];
        },
        body: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24.0),
            ),
            color: Pallete.whiteColor,
          ),
          child: ref.watch(getAllPostProvider).when(
                data: (data) {
                  if (data.isEmpty) {
                    return const Center(
                      child: Text(
                        'Be the first to post here 😋',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(24.0),
                    itemBuilder: (context, index) {
                      final postCard = data[index];
                      return InkWell(
                        onLongPress: () {
                          print('Noice');
                          //TODO: Admin and current user activities
                        },
                        onTap: () =>
                            navigateToPostDetailScreen(context, postCard),
                        child: PostCard(
                          userName: postCard.userName,
                          avatar: 'assets/images/blank_profile_picture.png',
                          branch: postCard.branch,
                          department: postCard.department,
                          image: postCard.images,
                          postType: postCard.postType,
                          content: postCard.content ?? "",
                          time: timeago.format(postCard.createdAt),
                        ),
                      );
                    },
                    itemCount: data.length,
                  );
                },
                error: (error, st) => ErrorText(error: error.toString()),
                loading: () => const Loader(),
              ),
        ),
      ),
    );
  }
}
