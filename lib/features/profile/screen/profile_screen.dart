// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:college_diary/core/banned_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:college_diary/core/widgets/error_text.dart';
import 'package:college_diary/core/widgets/loader.dart';
import 'package:college_diary/core/widgets/profile_acitivity_count_card.dart';
import 'package:college_diary/core/widgets/post_card.dart';
import 'package:college_diary/features/auth/controller/auth_controller.dart';
import 'package:college_diary/features/post/controller/post_controller.dart';
import 'package:college_diary/model/post_model.dart';
import 'package:college_diary/theme/pallete.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends ConsumerWidget {
  final String uid;
  const ProfileScreen({
    super.key,
    required this.uid,
  });

  void navigateToPostDetailScreen(BuildContext context, Post post) {
    Routemaster.of(context).push("/post-detail/${post.pid}");
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(userProvider);
    final foundUser = ref.watch(getUserDataProvider(uid));
    return foundUser.when(
      data: (user) => Scaffold(
        body: user!.isBanned
            ? const BannedScreen()
            : Center(
                child: NestedScrollView(
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        title: const Text(
                          "Profile",
                          style: TextStyle(
                            color: Pallete.whiteColor,
                            fontSize: 24.0,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                        backgroundColor: Pallete.blueColor,
                        floating: true,
                        snap: true,
                        actions: [
                          user.uid == ref.watch(userProvider)!.uid
                              ? Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: ElevatedButton.icon(
                                    onPressed: () => ref.read(signOutProvider),
                                    icon: const Icon(Icons.exit_to_app),
                                    label: const Text('Logout'),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            Container(
                              decoration:
                                  BoxDecoration(color: Pallete.blueColor),
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        radius: 30.0,
                                        backgroundImage: user.profilePic.isEmpty
                                            ? const NetworkImage(
                                                'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                                              )
                                            : NetworkImage(user.profilePic),
                                      ),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          //Post
                                          ProfileActivityCountCard(
                                            activityName: 'Post',
                                            count: 10,
                                          ),
                                          SizedBox(width: 10.0),
                                          // Joined Clubs
                                          ProfileActivityCountCard(
                                            activityName: 'Joined Club',
                                            count: 2,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(
                                      right: 5.0,
                                      left: 5.0,
                                      top: 3.0,
                                      bottom: 3.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: user.isVerifiedByAdmin
                                          ? Colors.green.withOpacity(0.5)
                                          : Colors.red.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Text(
                                      user.isVerifiedByAdmin
                                          ? "Verified"
                                          : "Not Verified",
                                      style: const TextStyle(
                                        fontSize: 8.0,
                                        color: Pallete.whiteColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            user.name,
                                            style: const TextStyle(
                                              color: Pallete.whiteColor,
                                            ),
                                          ),
                                          Text(
                                            user.enrollmentNumber,
                                            style: TextStyle(
                                              fontSize: 10.0,
                                              color: Pallete.whiteColor
                                                  .withOpacity(0.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                      //! ADMIN: Only Admin Restriction --------------------------------
                                      currentUser!.isAdmin
                                          ? Row(
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    final url = Uri(
                                                        scheme: 'tel',
                                                        path: user.phoneNumber);

                                                    if (await canLaunchUrl(
                                                        url)) {
                                                      launchUrl(url);
                                                    }
                                                  },
                                                  child: const Icon(
                                                    Icons.call,
                                                    color: Pallete.whiteColor,
                                                  ),
                                                ),
                                                const SizedBox(width: 20.0),
                                                InkWell(
                                                  onTap: () async {
                                                    final url = Uri(
                                                      scheme: 'mailto',
                                                      path: user.email,
                                                    );
                                                    if (await canLaunchUrl(
                                                        url)) {
                                                      launchUrl(url);
                                                    }
                                                  },
                                                  child: const Icon(
                                                    Icons.mail,
                                                    color: Pallete.whiteColor,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : const SizedBox()
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
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
                    child: ref.watch(getCurrentUserPost(user!.uid)).when(
                          data: (data) {
                            if (data.isEmpty) {
                              return const Center(
                                child: Text(
                                  'Ready to share your thoughts? Start by creating your first post!',
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
                                  onTap: () => navigateToPostDetailScreen(
                                      context, postCard),
                                  child: PostCard(
                                    uid: postCard.uid,
                                    userName: postCard.userName,
                                    avatar:
                                        'assets/images/blank_profile_picture.png',
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
                          error: (error, st) =>
                              ErrorText(error: error.toString()),
                          loading: () => const Loader(),
                        ),
                  ),
                ),
              ),
      ),
      error: (error, st) => ErrorText(error: error.toString()),
      loading: () => const Loader(),
    );
  }
}
