import 'package:cached_network_image/cached_network_image.dart';
import 'package:duluin_app/contants/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../controllers/banner-controller.dart';
import '../../models/banner-model.dart';
import '../partials/header-navigation.dart';

class DetailBannerPage extends StatefulWidget {
  final String slug;
  const DetailBannerPage({super.key, required this.slug});

  @override
  State<DetailBannerPage> createState() => _DetailBannerPageState();
}

class _DetailBannerPageState extends State<DetailBannerPage> {
  BannerController bannerController = BannerController();
  BannerModel? _bannerData;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> _getBlogData() async {
    BannerModel? blogData =
        await bannerController.bannerDetailService(context, widget.slug);
    setState(() {
      _bannerData = blogData;
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

    print('aposoapsoap: ${_bannerData}');

    return Scaffold(
      appBar: HeaderNavigationAppbar(
        isShowBackButton: true,
        titleText: 'Detail Promo',
        isTitleText: true,
        isShowNotificationButton: true,
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: CachedNetworkImage(
                      imageUrl: _bannerData!.imgUrl,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    _bannerData!.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: size.width * 0.05,
                    ),
                  ),
                  SizedBox(height: 10),
                  HtmlWidget(
                    _bannerData!.content,
                  ),
                ],
              ),
            ),
    );
  }
}
