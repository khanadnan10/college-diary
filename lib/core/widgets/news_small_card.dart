import 'package:flutter/material.dart';
import 'package:college_diary/core/widgets/custom_cached_netork_image.dart';
import 'package:college_diary/theme/pallete.dart';

class NewsSmallcard extends StatelessWidget {
  const NewsSmallcard({
    Key? key,
    required this.author,
    required this.image,
    required this.title,
    required this.dateTime,
  }) : super(key: key);

  final String author;
  final String? image;
  final String title;
  final String dateTime;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 4.0,
        vertical: 10.0,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          image != null
              ? Flexible(
                  child: Container(
                    height: size.height * 0.12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: customCachedNetworkImage(
                      image,
                      borderRadius: 8,
                    ),
                  ),
                )
              : const SizedBox(),
          const SizedBox(width: 6),
          Flexible(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  author,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 10.0,
                    color: Pallete.greyColor.withOpacity(0.5),
                  ),
                ),
                Text(
                  title,
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0,
                    color: Pallete.blueColor,
                  ),
                ),
                Text(
                  dateTime,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 10.0,
                    color: Pallete.greyColor.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}