import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:shimmer/shimmer.dart';
import 'package:college_diary/core/enums/post_enum.dart';
import 'package:college_diary/theme/pallete.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    Key? key,
    required this.userName,
    required this.uid,
    required this.avatar,
    required this.branch,
    required this.department,
    required this.image,
    required this.content,
    required this.time,
    required this.postType,
  }) : super(key: key);

  final String userName;
  final String uid;
  final String? avatar;
  final String branch;
  final String department;
  final String? image;
  final String content;
  final String time;
  final String postType;

  void navigateToProfileScreen(BuildContext context, String uid) {
    Routemaster.of(context).push("/profile/$uid");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Pallete.whiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => navigateToProfileScreen(context, uid),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: avatar != null
                          ? NetworkImage(
                              avatar!,
                            ) as ImageProvider
                          : AssetImage(avatar!),
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          maxLines: 1,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Pallete.blueColor,
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          "$branch, $department",
                          style: TextStyle(
                            color: Pallete.blueColor.withOpacity(0.5),
                            fontSize: 10.0,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Text(
                  time,
                  style: TextStyle(
                    color: Pallete.blueColor.withOpacity(0.5),
                    fontSize: 10.0,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            content,
            maxLines: 3,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              color: Pallete.blueColor,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10.0),
          postType == PostType.image.name.toString()
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(16.0),
                  child: AspectRatio(
                    aspectRatio: 1 / 0.8,
                    child: CachedNetworkImage(
                      imageUrl: image!,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey,
                        highlightColor: Colors.grey.shade100,
                        enabled: true,
                        child: Container(
                          color: Pallete.greyColor.withOpacity(0.3),
                        ),
                      ),
                      errorWidget: (context, url, error) => const Center(
                        child: Icon(Icons.error),
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
