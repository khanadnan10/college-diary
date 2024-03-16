import 'package:college_diary/core/banned_screen.dart';
import 'package:college_diary/core/utils.dart';
import 'package:college_diary/core/widgets/error_text.dart';
import 'package:college_diary/core/widgets/loader.dart';
import 'package:college_diary/core/widgets/post_card.dart';
import 'package:college_diary/features/auth/controller/auth_controller.dart';
import 'package:college_diary/features/post/controller/post_controller.dart';
import 'package:college_diary/model/post_model.dart';
import 'package:college_diary/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:routemaster/routemaster.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  void navigateToPostDetailScreen(BuildContext context, Post post) {
    Routemaster.of(context).push("/post-detail/${post.pid}");
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = ref.watch(userProvider);
    return Scaffold(
      backgroundColor: Pallete.blueColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Pallete.blueColor,
              floating: true,
              snap: true,
              title: Row(
                children: [
                  // Icon(
                  //   Icons.school,
                  //   color: Pallete.whiteColor,
                  // ),
                  // SizedBox(
                  //   width: 5,
                  // ),
                  Text(
                    "College Diary",
                    style: GoogleFonts.gloriaHallelujah(
                      color: Pallete.whiteColor,
                      fontSize: 26.0,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.fade,
                  ),
                ],
              ),
              // flexibleSpace: Padding(
              //   padding: const EdgeInsets.all(12.0).copyWith(bottom: 0),
              //   child: const Column(
              //     crossAxisAlignment: CrossAxisAlignment.stretch,
              //     children: [
              //       Flexible(
              //         child: Text(
              //           "Explore",
              //           style: TextStyle(
              //             color: Pallete.whiteColor,
              //             fontSize: 24.0,
              //           ),
              //           softWrap: true,
              //           overflow: TextOverflow.fade,
              //         ),
              //       ),
              //       //TODO: Show latest News or Notification by Admin here
              //     ],
              //   ),
              // ),
            ),
          ];
        },
        body: Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24.0),
              ),
              color: Pallete.greyColor.withOpacity(0.2)
              // color: Color.fromARGB(255, 252, 252, 252), //@ Color combo
              ),
          child: currentUser == null
              ? const Loader()
              : ref.watch(userProvider)!.isBanned
                  ? const BannedScreen()
                  : ref.watch(getAllPostProvider).when(
                        data: (data) {
                          if (data.isEmpty) {
                            return Center(
                              child: Text(
                                'Be the first to post here 😋',
                                style: TextStyle(
                                  color: Pallete.whiteColor.withOpacity(0.5),
                                ),
                              ),
                            );
                          }
                          return ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(16.0),
                            itemBuilder: (context, index) {
                              final postCard = data[index];
                              return InkWell(
                                onLongPress: () {
                                  //TODO: Admin and current user activities
                                  if (currentUser.uid == postCard.uid) {
                                    showCustomDeleteBottomSheet(
                                      context,
                                      ref,
                                      postCard,
                                    );
                                  } else if (currentUser.isAdmin) {
                                    showCustomDeleteBottomSheet(
                                        context, ref, postCard,
                                        color: Colors.red,
                                        description:
                                            "Admin has the authority to take disciplinary action on any post. Do you want to delete this post?");
                                  }
                                },
                                onTap: () => navigateToPostDetailScreen(
                                    context, postCard),
                                child: PostCard(
                                  userName: postCard.userName,
                                  avatar: postCard.avatar != null
                                      ? postCard.avatar!
                                      : 'assets/images/blank_profile_picture.png',
                                  branch: postCard.branch,
                                  department: postCard.department,
                                  image: postCard.images,
                                  postType: postCard.postType,
                                  uid: postCard.uid,
                                  content: postCard.content ?? "",
                                  time: timeago.format(postCard.createdAt),
                                ),
                              );
                            },
                            itemCount: data.length,
                          );
                        },
                        error: (error, st) =>
                            ErrorText(error: error.toString()),
                        loading: () => const Loader(),
                      ),
        ),
      ),
    );
  }
}
