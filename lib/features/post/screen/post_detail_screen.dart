import 'package:college_diary/core/widgets/error_text.dart';
import 'package:college_diary/core/widgets/loader.dart';
import 'package:college_diary/core/enums/post_enum.dart';
import 'package:college_diary/features/post/controller/post_controller.dart';
import 'package:college_diary/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/custom_cached_netork_image.dart';
import 'package:routemaster/routemaster.dart';
import 'package:timeago/timeago.dart' as timeago;

class PostDetailScreen extends ConsumerWidget {
  final String postId;
  const PostDetailScreen({
    Key? key,
    required this.postId,
  }) : super(key: key);

  void popBack(BuildContext context) => Routemaster.of(context).pop();

  void navigateToProfileScreen(BuildContext context, String uid) {
    Routemaster.of(context).push("/profile/$uid");
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Pallete.blueColor,
          leading: IconButton(
            onPressed: () => popBack(context),
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Pallete.whiteColor,
            ),
          ),
        ),
        backgroundColor: Pallete.blueColor,
        body: ref.watch(getPostById(postId)).when(
              data: (data) => SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      data.postType == PostType.image.name.toString()
                          ? AspectRatio(
                              aspectRatio: 1 / 0.8,
                              child: customCachedNetworkImage(data.images!),
                            )
                          : const SizedBox(),
                      const SizedBox(height: 40.0),
                      GestureDetector(
                        onTap: () => navigateToProfileScreen(context, data.uid),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                (data.images != null)
                                    ? CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(data.avatar!),
                                      )
                                    : const CircleAvatar(
                                        backgroundImage: AssetImage(
                                            'assets/images/blank_profile_picture.png'),
                                      ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.userName,
                                      maxLines: 1,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Pallete.whiteColor,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    Text(
                                      "${data.branch}, ${data.department}",
                                      style: TextStyle(
                                        color:
                                            Pallete.whiteColor.withOpacity(0.5),
                                        fontSize: 10.0,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Text(
                              timeago.format(data.createdAt),
                              style: const TextStyle(
                                color: Pallete.whiteColor,
                                fontSize: 10.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        data.content!,
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Pallete.whiteColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              error: (error, st) => ErrorText(error: error.toString()),
              loading: () => const Loader(),
            ),
      ),
    );
  }
}
