import 'package:college_diary/core/route_name.dart';
import 'package:college_diary/core/widgets/custom_cached_netork_image.dart';
import 'package:college_diary/core/widgets/error_text.dart';
import 'package:college_diary/core/widgets/loader.dart';
import 'package:college_diary/core/widgets/news_small_card.dart';
import 'package:college_diary/features/news/controller/news_controller.dart';
import 'package:college_diary/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:routemaster/routemaster.dart';

class NewsScreen extends ConsumerWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Routemaster.of(context).push(RouteName.createNewsScreen),
        //Todo create news if the user is admin or allowed to create news

        backgroundColor: Pallete.blueColor,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Pallete.whiteColor,
        ),
      ),
      body: ref.refresh(getNewsProvider).when(
            data: (news) {
              return NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) {
                  return [
                    SliverAppBar(
                      centerTitle: true,
                      title: Text(
                        "NRI Times",
                        style: GoogleFonts.cantataOne(
                          color: Pallete.whiteColor,
                          fontSize: 30.0,
                        ),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                      backgroundColor: Pallete.blueColor,
                      floating: true,
                      snap: true,
                    ),
                  ];
                },
                body: news.isEmpty
                    ? Center(
                        child: Text(
                        'No News 📰',
                        style: TextStyle(
                            color: Pallete.greyColor.withOpacity(0.5)),
                      ))
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              //! Top News
                              GestureDetector(
                                onTap: () => Routemaster.of(context).push(
                                  RouteName.newsDetailScreen
                                      .replaceAll(':newsId', news[0].id),
                                ),
                                child: Container(
                                  height: news.first.image != null ? 200 : 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                    color: Colors.black,
                                  ),
                                  child: Stack(
                                    children: [
                                      news[0].image != null
                                          ? customCachedNetworkImage(
                                              news[0].image,
                                              borderRadius: 8,
                                            )
                                          : const SizedBox(),
                                      Container(
                                        height: 200,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          color: Colors.red,
                                          gradient: const LinearGradient(
                                            begin: Alignment.topCenter,
                                            stops: [0.3, 1],
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.transparent,
                                              Pallete.blackColor,
                                            ],
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      news[0].title,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 16.0,
                                                        color:
                                                            Pallete.whiteColor,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  const Icon(
                                                    Icons.arrow_outward_rounded,
                                                    color: Pallete.whiteColor,
                                                    size: 30.0,
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                news[0].department,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 10.0,
                                                  color: Pallete.whiteColor
                                                      .withOpacity(0.6),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              //! Top Stories
                              const SizedBox(
                                height: 10,
                              ),

                              if (news.length > 1)
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Top Stories',
                                    style: TextStyle(
                                      color: Pallete.blueColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              const SizedBox(
                                height: 10,
                              ),
                              if (news.length > 1)
                                ListView.builder(
                                  itemCount: news.length -
                                      1, //! change this to dynamic
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    final data = news[index + 1];
                                    return GestureDetector(
                                      onTap: () => Routemaster.of(context).push(
                                        RouteName.newsDetailScreen
                                            .replaceAll(':newsId', data.id),
                                      ),
                                      child: NewsSmallcard(
                                        author: data.author,
                                        image: data.image,
                                        title: data.title,
                                        dateTime: DateFormat.yMMMEd()
                                            .format(
                                              data.createdAt,
                                            )
                                            .toString(),
                                      ),
                                    );
                                  },
                                ),
                              if (news.length <= 1)
                                Center(
                                  child: Text(
                                    'timessssssssssssssssssssss 😋',
                                    style: TextStyle(
                                      color: Pallete.greyColor.withOpacity(0.3),
                                    ),
                                  ),
                                ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
              );
            },
            error: (error, st) => ErrorText(error: error.toString()),
            loading: () => const Loader(),
          ),
    );
  }
}
