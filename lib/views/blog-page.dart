import 'package:cached_network_image/cached_network_image.dart';
import 'package:duluin_app/contants/attribute.dart';
import 'package:duluin_app/contants/color.dart';
import 'package:duluin_app/controllers/blog-controller.dart';
import 'package:duluin_app/models/blog-model.dart';
import 'package:duluin_app/views/partials/header-navigation.dart';
import 'package:duluin_app/views/shimmer/blog-shimmer.dart';
import 'package:flutter/material.dart';

import '../contants/routes.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  BlogController blogController = BlogController();
  List<BlogModel>? _blogData;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> _getBlogData() async {
    List<BlogModel>? blogData = await blogController.blogDataService(context);

    setState(() {
      _blogData = blogData;
    });
  }

  Future loadData() async {
    setState(() => isLoading = true);

    await Future.wait([
      _getBlogData(),
    ]);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: HeaderNavigationAppbar(
        isShowBackButton: false,
        titleText: 'Blog & Event',
        isTitleText: true,
        isShowNotificationButton: true,
        isCenterTitle: true,
        sizeImage: 0,
      ),
      body: isLoading
          ? BlogShimmer()
          : RefreshIndicator(
              onRefresh: () async {
                loadData();
              },
              color: COLOR_PRIMARY_GREEN,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: SCROLL_PADDING_HORIZONTAL,
                  vertical: SCROLL_PADDING_VERTICAL,
                ),
                child: Column(
                  children: [
                    ListView.builder(
                      itemCount: _blogData?.length ?? 0,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        BlogModel blog = _blogData![index];

                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              detailBlogPageRoute,
                              arguments: {
                                'slug': blog.slug,
                              },
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Card(
                              margin: EdgeInsets.zero,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(12.5),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: CachedNetworkImage(
                                        imageUrl: blog.imgUrl,
                                        width: size.width * 0.25,
                                        height: size.height * 0.110,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: 7.5),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            blog.title,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: COLOR_PRIMARY_GREEN,
                                              fontWeight: FontWeight.bold,
                                              fontSize: size.width * 0.0325,
                                            ),
                                          ),
                                          SizedBox(height: 2.5),
                                          Text(
                                            blog.contentCover,
                                            maxLines: 4,
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: size.width * 0.030,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
