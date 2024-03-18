import 'package:college_diary/core/widgets/custom_cached_netork_image.dart';
import 'package:college_diary/core/widgets/error_text.dart';
import 'package:college_diary/core/widgets/loader.dart';
import 'package:college_diary/features/auth/controller/auth_controller.dart';
import 'package:college_diary/features/news/controller/news_controller.dart';
import 'package:college_diary/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:timeago/timeago.dart' as timeago;

class NewsDetailsScreen extends ConsumerWidget {
  const NewsDetailsScreen({
    super.key,
    required this.newsId,
  });

  final String newsId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ref.watch(getNewsByIdProvider(newsId)).when(
            data: (news) => NestedScrollView(
              physics: const BouncingScrollPhysics(),
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    backgroundColor: Pallete.blueColor,
                    leading: IconButton(
                      onPressed: () => Routemaster.of(context).pop(),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                    automaticallyImplyLeading: true,
                    actions: [
                      ref.watch(userProvider)!.isAdmin
                          ? PopupMenuButton(
                              iconColor: Pallete.whiteColor,
                              onSelected: (value) {
                                switch (value) {
                                  case 'Delete':
                                    ref
                                        .watch(newsControllerProvider.notifier)
                                        .deletePost(context, news);
                                    Routemaster.of(context).pop();
                                    break;

                                  default:
                                }
                                return;
                              },
                              itemBuilder: (context) {
                                return [
                                  const PopupMenuItem(
                                    value: 'Delete',
                                    child: Text('Delete'),
                                  )
                                ];
                              },
                            )
                          : const SizedBox(),
                      // IconButton(
                      //   onPressed: () {
                      // ref
                      //     .watch(newsControllerProvider.notifier)
                      //     .deletePost(context, news);
                      //     Routemaster.of(context).pop();
                      //   },
                      //   icon: const Icon(
                      //     Icons.more_vert,
                      //     color: Colors.white,
                      //   ),
                      // ),
                    ],
                    floating: true,
                  ),
                  SliverToBoxAdapter(
                    child: news.image != null
                        ? SizedBox(
                            height: 250,
                            child: customCachedNetworkImage(
                              news.image!,
                              borderRadius: 0,
                            ),
                          )
                        : const SizedBox(),
                  )
                ];
              },
              body: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        news.department,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Pallete.blueColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 2.0,
                      ),
                      Text(
                        news.title,
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: Pallete.greyColor.withOpacity(0.5),
                          ),
                          Text(
                            news.author,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Pallete.greyColor.withOpacity(0.5),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                        ],
                      ),
                      Text(
                        timeago.format(news.createdAt).toString(),
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Pallete.greyColor.withOpacity(0.5),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        news.content,
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Pallete.greyColor.withOpacity(0.7),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            error: (error, st) => ErrorText(error: error.toString()),
            loading: () => const Loader(),
          ),
    );
  }
}
