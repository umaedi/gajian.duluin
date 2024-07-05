import 'package:duluin_app/controllers/page-dynamic-controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../contants/attribute.dart';
import '../partials/header-navigation.dart';
import '../shimmer/page-shimmer.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  PageDynamicController pageController = PageDynamicController();
  late Map<String, dynamic> pageData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadPage();
  }

  Future<void> loadPage() async {
    var data = await pageController.pagePrivacyPolicy(context);
    if (data != null) {
      setState(() {
        pageData = data['data'];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderNavigationAppbar(
        isShowBackButton: true,
        titleText: 'Privacy Policy',
        isTitleText: true,
        isShowNotificationButton: false,
        isCenterTitle: true,
        sizeImage: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.symmetric(
          horizontal: SCROLL_PADDING_HORIZONTAL,
          vertical: SCROLL_PADDING_VERTICAL,
        ),
        child: isLoading
            ? PageShimmer()
            : Column(
                children: [
                  Card(
                    elevation: 5,
                    margin: EdgeInsets.zero,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(12.5),
                      child: HtmlWidget(
                        pageData['content'],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
