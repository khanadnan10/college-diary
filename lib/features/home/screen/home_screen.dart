import 'package:college_diary/core/security/banned_screen.dart';
import 'package:college_diary/core/routes/route_name.dart';
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
      // endDrawer: currentUser != null
      //     ? currentUser.isAdmin
      //         ? Drawer(
      //             // backgroundColor: Colors.red,
      //             shape: const RoundedRectangleBorder(),
      //             child: Column(
      //               children: [
      //                 const SizedBox(
      //                   height: 20.0,
      //                 ),
      //                 CircleAvatar(
      //                   radius: 50.0,
      //                   backgroundImage: currentUser.profilePic!.isEmpty
      //                       ? Image.asset(
      //                           'assets/images/blank_profile_picture.png',
      //                         ) as ImageProvider
      //                       : NetworkImage(currentUser.profilePic!),
      //                 ),
      //                 const SizedBox(
      //                   height: 20.0,
      //                 ),
      //                 ActionChip(
      //                   label: const Text('Admin'),
      //                   disabledColor: Colors.green.shade100,
      //                   shape: RoundedRectangleBorder(
      //                     side: BorderSide(
      //                       color: Colors.green.shade200,
      //                     ),
      //                     borderRadius: BorderRadius.circular(20.0),
      //                   ),
      //                 ),
      //                 const SizedBox(
      //                   height: 10.0,
      //                 ),
      //                 Text(
      //                   currentUser.name,
      //                   style: const TextStyle(
      //                     fontSize: 18,
      //                   ),
      //                 ),
      //                 const SizedBox(
      //                   height: 10.0,
      //                 ),
      //                 ListTile(
      //                   leading: const Icon(Icons.space_dashboard),
      //                   tileColor: Pallete.whiteColor.withOpacity(0.2),
      //                   title: const Text('Dashboard'),
      //                   onTap: () {
      //                     Routemaster.of(context)
      //                         .push(RouteName.adminBottomNavBarScreen);
      //                   },
      //                 )
      //               ],
      //             ),
      //           )
      //         : null
      //     : null,
      drawer: Drawer(
        shape: const RoundedRectangleBorder(),
        child: Column(
          children: [
            const Spacer(),
            ListTile(
              tileColor: Pallete.greyColor.withOpacity(0.1),
              title: const Text(
                'About us ♥',
                style: TextStyle(color: Pallete.blueColor),
              ),
            )
          ],
        ),
      ),
      backgroundColor: Pallete.blueColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Pallete.blueColor,
              floating: true,
              snap: true,
              // leading: null,
              // automaticallyImplyLeading: false,
              actions: [
                Builder(
                  builder: (context) => Container(
                    margin: const EdgeInsets.only(right: 10.0),
                    decoration: BoxDecoration(
                      color: Pallete.whiteColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.admin_panel_settings,
                        color: Colors.red,
                      ),
                      padding: const EdgeInsets.all(0),
                      onPressed: () => Routemaster.of(context)
                              .push(RouteName.adminBottomNavBarScreen),
                      tooltip: MaterialLocalizations.of(context)
                          .openAppDrawerTooltip,
                    ),
                  ),
                ),
              ],
              collapsedHeight: kToolbarHeight + 25,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
              //TODO: Filter out as per the department
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
                                  avatar: postCard.avatar ??
                                      'assets/images/blank_profile_picture.png',
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
