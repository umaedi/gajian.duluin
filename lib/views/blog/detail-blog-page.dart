import 'package:cached_network_image/cached_network_image.dart';
import 'package:duluin_app/controllers/blog-controller.dart';
import 'package:duluin_app/views/partials/header-navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../contants/color.dart';
import '../../models/blog-model.dart';
import '../../services/date-formatter.dart';

class DetailBlogPage extends StatefulWidget {
  final String slug;

  const DetailBlogPage({super.key, required this.slug});

  @override
  State<DetailBlogPage> createState() => _DetailBlogPageState();
}

class _DetailBlogPageState extends State<DetailBlogPage> {
  BlogController blogController = BlogController();
  BlogModel? _blogData;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> _getBlogData() async {
    BlogModel? blogData =
        await blogController.blogDetailService(context, widget.slug);
    setState(() {
      _blogData = blogData;
    });
  }

  Future<void> loadData() async {
    setState(() => isLoading = true);

    await Future.wait([
      _getBlogData(),
    ]);

    setState(() => isLoading = false);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: HeaderNavigationAppbar(
        isShowBackButton: true,
        titleText: 'Detail Blog',
        isTitleText: true,
        isShowNotificationButton: false,
        isCenterTitle: true,
        sizeImage: 0,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: COLOR_PRIMARY_GREEN,
              ),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: CachedNetworkImage(
                        imageUrl: _blogData!.imgUrl,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            FontAwesomeIcons.solidCalendar,
                            size: size.width * 0.030,
                            color: Colors.black54,
                          ),
                          SizedBox(width: 7.5),
                          Text(
                            formatDateString(_blogData!.date),
                            style: TextStyle(
                              fontSize: size.width * 0.030,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: COLOR_PRIMARY_GREEN,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              FontAwesomeIcons.solidEye,
                              size: size.width * 0.030,
                              color: Colors.white,
                            ),
                            SizedBox(width: 7.5),
                            Text(
                              _blogData!.viewer.toString(),
                              style: TextStyle(
                                fontSize: size.width * 0.030,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    _blogData!.title,
                    style: TextStyle(
                      color: COLOR_PRIMARY_GREEN,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10),
                  HtmlWidget(
                    _blogData!.content,
                  )
                ],
              ),
            ),
    );
  }
}
